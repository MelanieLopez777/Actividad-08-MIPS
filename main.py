from tkinter import *
from tkinter import ttk
from tkinter import filedialog

# Paleta de colores y fuentes globales
COLORES = {
    'fondo': '#121212',
    'panel': '#1E1E1E',
    'principal': '#418CB7',
    'principal_hover': '#2EB7EA',
    'secundario': '#A44CE8',
    'secundario_hover': '#6A0080',
    'texto': '#E1E1E1',
    'borde': '#373737',
    'texto_oscuro': '#1E1E1E'
}

FUENTES = {
    'normal': ('Segoe UI', 9),
    'bold': ('Segoe UI', 9, 'bold'),
    'titulo': ('Segoe UI', 11),
    'mono': ('Consolas', 10)
}

# Variables globales
content_ensamblador = ""
instrucciones_decodificadas = []
boton_ver_decodificado = None

def crear_estilos():
    """Devuelve todos los estilos organizados"""
    return {
        'frame': {
            'bg': COLORES['fondo'],
            'padx': 15,
            'pady': 15
        },
        'frame_borde': {
            'bg': COLORES['borde']
        },
        'label': {
            'bg': COLORES['fondo'],
            'fg': COLORES['texto'],
            'font': FUENTES['titulo']
        },
        'boton_principal': {
            'bg': COLORES['principal'],
            'fg': 'white',
            'activebackground': COLORES['principal_hover'],
            'activeforeground': 'white',
            'font': FUENTES['bold'],
            'relief': 'flat',
            'bd': 0,
            'padx': 15,
            'pady': 6,
            'highlightthickness': 0
        },
        'boton_secundario': {
            'bg': COLORES['secundario'],
            'fg': 'white',
            'activebackground': COLORES['secundario_hover'],
            'font': FUENTES['bold'],
            'relief': 'flat',
            'bd': 0
        },
        'texto': {
            'bg': COLORES['panel'],
            'fg': COLORES['texto'],
            'font': FUENTES['mono'],
            'insertbackground': COLORES['texto'],
            'selectbackground': COLORES['principal'],
            'selectforeground': 'white',
            'relief': 'flat',
            'bd': 1,
            'highlightthickness': 0,
            'insertwidth': 2
        }
    }

def configurar_hover(boton, color_normal, color_hover):
    """Configura efectos hover para botones"""
    boton.bind("<Enter>", lambda e: boton.config(bg=color_hover))
    boton.bind("<Leave>", lambda e: boton.config(bg=color_normal))

def abrir_archivo():
    global content_ensamblador, text_contenido, file_path  
    
    file_path = filedialog.askopenfilename(title="Abrir archivo", filetypes=[("Archivo ensamblador", "*.asm")])
    
    if file_path:
        try:
            with open(file_path, 'r') as file:
                content_ensamblador = file.read()
                
                # Reconstruir la interfaz si fue limpiada por un archivo vacío previo
                if not any(isinstance(child, Frame) for child in root.winfo_children()):
                    reconstruir_interfaz()
                
                # Actualizar el contenido del texto
                if 'text_contenido' in globals() and text_contenido.winfo_exists():
                    text_contenido.delete('1.0', END)
                    text_contenido.insert(END, content_ensamblador)
                
                # Ocultar el botón de ver decodificado si existe
                if boton_ver_decodificado and boton_ver_decodificado.winfo_exists():
                    boton_ver_decodificado.grid_remove()
                
                # Actualizar la etiqueta de la ruta del archivo
                if 'label_ruta' in globals() and label_ruta.winfo_exists():
                    label_ruta.config(text=f"Archivo: {file_path}")
                else:
                    mostrar_ruta_archivo(file_path)
                    
        except Exception as e:
            print(f"Error al leer el archivo: {e}")
            archivo_vacio()

def mostrar_ruta_archivo(ruta):
    """Muestra la ruta del archivo en la interfaz"""
    global label_ruta
    estilos = crear_estilos()
    
    # Frame para la ruta del archivo (debajo de los botones)
    frame_ruta = Frame(root, **estilos['frame'])
    frame_ruta.pack(pady=(0, 10), fill=X, padx=20)
    
    # Etiqueta con la ruta del archivo
    label_ruta = Label(frame_ruta, 
                      text=f"📁 Archivo: {ruta}", 
                      fg=COLORES['texto'],
                      bg=COLORES['fondo'],
                      font=FUENTES['normal'],
                      anchor='w',
                      wraplength=700)  # Ajusta según el ancho de tu ventana
    label_ruta.pack(fill=X)
    
    # Botón para copiar la ruta al portapapeles
    boton_copiar = Button(frame_ruta, 
                         text="📋 Copiar ruta", 
                         command=lambda: root.clipboard_append(ruta),
                         **estilos['boton_secundario'])
    boton_copiar.pack(side=RIGHT)
    configurar_hover(boton_copiar, COLORES['secundario'], COLORES['secundario_hover'])

def mostrar_exito():
    # Crear ventana emergente
    ventana_exito = Toplevel(root)
    ventana_exito.title("¡Éxito!")
    ventana_exito.geometry("400x200")
    ventana_exito.resizable(False, False)
    ventana_exito.configure(bg=COLORES['fondo'])
    
    # Centrar la ventana emergente
    ventana_exito.grab_set()  # Hace que la ventana sea modal
    ventana_exito.transient(root)  # Relación con la ventana principal
    
    # Icono de éxito (puedes usar un emoji o imagen)
    label_icono = Label(ventana_exito, 
                      text="✓", 
                      font=("Arial", 48),
                      fg="#4CAF50",  # Verde
                      bg=COLORES['fondo'])
    label_icono.pack(pady=(20, 0))
    
    # Mensaje principal
    label_mensaje = Label(ventana_exito,
                         text="Decodificación completada",
                         font=FUENTES['titulo'],
                         fg=COLORES['texto'],
                         bg=COLORES['fondo'])
    label_mensaje.pack(pady=10)
    
    # Detalles adicionales
    label_detalle = Label(ventana_exito,
                         text=f"Se procesaron {len(instrucciones_decodificadas)} instrucciones",
                         font=FUENTES['normal'],
                         fg=COLORES['texto'],
                         bg=COLORES['fondo'])
    label_detalle.pack()
    
    # Botón para cerrar
    boton_ok = Button(ventana_exito,
                     text="Aceptar",
                     command=ventana_exito.destroy,
                     **crear_estilos()['boton_principal'])
    boton_ok.pack(pady=20)
    configurar_hover(boton_ok, COLORES['principal'], COLORES['principal_hover'])

def decodificar():
    global instrucciones_decodificadas, boton_ver_decodificado
    
    if not content_ensamblador.strip():
        archivo_vacio()
        return
         
    diccionario_instruction = {
        "and": 36, "or": 37, "add": 32, "sub": 34,
        "nop": 0, "sll": 0, "j": 2, "slt": 42, "sw": 43, "sb": 40,
        "sh": 41, "lw": 35, "lb": 32, "lbu": 36, "addi": 8, "slti": 10, "andi": 12,
        "ori": 13, "beq": 4
    }

    diccionario_instruction_type = {
        "and": "r", "or": "r", "add": "r", "sub": "r", 
        "slt": "r", "sw": "i", "sb": "i", "sh": "i",
        "lb": "i", "lbu": "i", "lw": "i", "addi": "i",
        "slti": "i", "andi": "i", "ori": "i", "beq": "i",
        "j": "j", "nop": "r", "sll": "r"
    }

    lineas = content_ensamblador.split("\n")
    instrucciones_decodificadas = []

    for linea in lineas:
        # Limpiar comentarios y espacios extra
        linea = linea.split('#')[0].strip()  # Elimina comentarios
        if not linea:  # Si la línea está vacía tras limpiar
            instrucciones_decodificadas.append("00000000000000000000000000000000")
            continue

        # Separar por espacios o comas, y eliminar cadenas vacías
        palabras = [p.strip() for p in linea.replace(',', ' ').split() if p.strip()]
        
        if not palabras:  # Línea vacía
            instrucciones_decodificadas.append("00000000000000000000000000000000")
            continue

        instruccion = palabras[0].lower()
        tipo = diccionario_instruction_type.get(instruccion, None)
        fila_decodificada = ""

        if tipo == "r":
            if instruccion == "nop":
                fila_decodificada = "00000000000000000000000000000000"
            elif instruccion == "sll":
                fila_decodificada += "000000"
                fila_decodificada += "00000"
                fila_decodificada += format(int(palabras[2][1:]), '05b')  # rt
                fila_decodificada += format(int(palabras[1][1:]), '05b')  # rd
                fila_decodificada += format(int(palabras[3]), '05b')      # sa
                fila_decodificada += format(diccionario_instruction.get(instruccion, 0), '06b')  # funct
            else:
                try:
                    fila_decodificada += "000000"
                    fila_decodificada += format(int(palabras[2][1:]), '05b')  # rs
                    fila_decodificada += format(int(palabras[3][1:]), '05b')  # rt
                    fila_decodificada += format(int(palabras[1][1:]), '05b')  # rd
                    fila_decodificada += "00000"
                    fila_decodificada += format(diccionario_instruction.get(instruccion, 0), '06b')  # funct
                except (IndexError, ValueError) as e:
                    print(f"Error en línea: {linea} - {e}")
                    fila_decodificada = "00000000000000000000000000000000"

        elif tipo == "i":
            try:
                fila_decodificada += format(diccionario_instruction.get(instruccion, 0), '06b')  # opcode
                fila_decodificada += format(int(palabras[2][1:]), '05b')  # rs
                fila_decodificada += format(int(palabras[1][1:]), '05b')  # rt
                # Manejar inmediato (puede ser negativo)
                inmediato = int(palabras[3])
                fila_decodificada += format(inmediato & 0xFFFF, '016b')  # 16 bits con signo
            except (IndexError, ValueError) as e:
                print(f"Error en línea: {linea} - {e}")
                fila_decodificada = "00000000000000000000000000000000"

        elif tipo == "j":
            try:
                fila_decodificada += format(diccionario_instruction.get(instruccion, 0), '06b')  # opcode
                fila_decodificada += format(int(palabras[1]), '026b')  # dirección
            except (IndexError, ValueError) as e:
                print(f"Error en línea: {linea} - {e}")
                fila_decodificada = "00000000000000000000000000000000"
        else:
            fila_decodificada = "00000000000000000000000000000000"
        
        instrucciones_decodificadas.append(fila_decodificada)

    # Escribir en el archivo (4 líneas de 8 bits cada una)
    with open('instrucciones.txt', 'w') as archivo:
        for item in instrucciones_decodificadas:
            for i in range(0, 32, 8):
                archivo.write(item[i:i+8] + "\n")
            
    mostrar_exito()
    
    if boton_ver_decodificado and boton_ver_decodificado.winfo_exists():
        boton_ver_decodificado.grid()
    else:
        mostrar_boton_decodificado()

def salir():
    root.quit()
    
def limpiar_frame(frame):   #Función de limpieza de frames
    for widget in frame.winfo_children():
        widget.destroy()

def archivo_vacio():
    
    # Limpiar el frame principal
    limpiar_frame(root)
    estilos = crear_estilos()
    
    # Crear frame principal para el mensaje de error
    frame_msg_empty_file = Frame(root, **estilos['frame'])
    frame_msg_empty_file.pack(pady=20, fill=BOTH, expand=True)
    
    # Mensaje de error
    Label(frame_msg_empty_file, 
          text="❌ Error: Archivo vacío o no válido", 
          **estilos['label']).pack(pady=(0, 20))
    
    # Frame para mostrar el contenido del archivo (si existe)
    if content_ensamblador.strip():
        frame_contenido = Frame(frame_msg_empty_file, **estilos['frame_borde'])
        frame_contenido.pack(fill=BOTH, expand=True, pady=(0, 20))
        
        # Área de texto para mostrar contenido
        text_error = Text(frame_contenido, **estilos['texto'])
        text_error.pack(side=LEFT, fill=BOTH, expand=True, padx=1, pady=1)
        text_error.insert(END, content_ensamblador)
        text_error.config(state=DISABLED)
        
        # Scrollbar
        scroll_y = Scrollbar(frame_contenido, orient=VERTICAL, command=text_error.yview)
        scroll_y.pack(side=RIGHT, fill=Y)
        text_error.config(yscrollcommand=scroll_y.set)
    
    # Frame para botones
    frame_botones = Frame(frame_msg_empty_file, **estilos['frame'])
    frame_botones.pack(pady=(20, 0))
    
    # Botón para elegir otro archivo
    boton_reintentar = Button(frame_botones, 
                             text="🔍 Elegir otro archivo", 
                             command=abrir_archivo, 
                             **estilos['boton_secundario'])
    boton_reintentar.grid(row=0, column=0, padx=10)
    configurar_hover(boton_reintentar, COLORES['secundario'], COLORES['secundario_hover'])
    
    # Botón para volver a la interfaz principal
    boton_volver = Button(frame_botones, 
                         text="Volver", 
                         command=reconstruir_interfaz, 
                         **estilos['boton_secundario'])
    boton_volver.grid(row=0, column=1, padx=10)
    configurar_hover(boton_volver, COLORES['secundario'], COLORES['secundario_hover'])
    
    # Botón para salir de la aplicación
    boton_salir = Button(frame_botones, 
                        text="Salir", 
                        command=salir, 
                        **estilos['boton_secundario'])
    boton_salir.grid(row=0, column=2, padx=10)
    configurar_hover(boton_salir, COLORES['secundario'], COLORES['secundario_hover'])

def reconstruir_interfaz():
    limpiar_frame(root)
    estilos = crear_estilos()
    
    root.configure(bg=COLORES['fondo'])
    
    # Frame superior
    frame_superior = Frame(root, **estilos['frame'])
    frame_superior.pack(pady=(20, 10), fill=X, padx=20)

    Label(frame_superior, text="🔍 Elige la ruta del archivo .asm", **estilos['label']).grid(row=0, column=0, padx=(0, 10))
    
    boton_abrir = Button(frame_superior, text="Abrir Archivo", command=abrir_archivo, **estilos['boton_principal'])
    boton_abrir.grid(row=0, column=1)
    configurar_hover(boton_abrir, COLORES['principal'], COLORES['principal_hover'])

    # Frame de botones principales
    frame_botones = Frame(root, **estilos['frame'])
    frame_botones.pack(pady=10, fill=X, padx=20)
    
    boton_decodificar = Button(frame_botones, text="Decodificar", command=decodificar, **estilos['boton_principal'])
    boton_decodificar.grid(row=0, column=0, padx=(0, 10))
    configurar_hover(boton_decodificar, COLORES['principal'], COLORES['principal_hover'])
    
    global boton_ver_decodificado
    boton_ver_decodificado = Button(frame_botones, text="Ver Código Decodificado", 
                                   command=mostrar_decodificado, **estilos['boton_principal'])
    boton_ver_decodificado.grid(row=0, column=1)
    configurar_hover(boton_ver_decodificado, COLORES['principal'], COLORES['principal_hover'])
    boton_ver_decodificado.grid_remove()

    # Frame para la ruta del archivo (nuevo)
    global label_ruta
    frame_ruta = Frame(root, **estilos['frame'])
    frame_ruta.pack(pady=(0, 10), fill=X, padx=20)
    
    label_ruta = Label(frame_ruta, 
                      text="Ningún archivo seleccionado", 
                      fg=COLORES['texto'],
                      bg=COLORES['fondo'],
                      font=FUENTES['normal'],
                      anchor='w',
                      wraplength=700)
    label_ruta.pack(fill=X)
    
    # Botón de salir (movido debajo del frame de ruta)
    boton_salir = Button(root, text="Salir", command=salir, **estilos['boton_secundario'])
    boton_salir.pack(side=BOTTOM, pady=(0, 20), ipadx=15, ipady=5)
    configurar_hover(boton_salir, COLORES['secundario'], COLORES['secundario_hover'])

    # Frame del área de texto
    frame_texto = Frame(root, **estilos['frame_borde'])
    frame_texto.pack(pady=(0, 20), fill=BOTH, expand=True, padx=20)

    global text_contenido
    text_contenido = Text(frame_texto, **estilos['texto'])
    text_contenido.pack(side=LEFT, fill=BOTH, expand=True, padx=1, pady=1)

    # Scrollbar
    scroll_y = Scrollbar(frame_texto, orient=VERTICAL, command=text_contenido.yview)
    scroll_y.pack(side=RIGHT, fill=Y)
    text_contenido.config(yscrollcommand=scroll_y.set)
    
    # Configurar scrollbar
    scroll_y.config(
        troughcolor=COLORES['panel'],
        bg=COLORES['borde'],
        activebackground=COLORES['principal']
    )

def mostrar_boton_decodificado():   #Función para mostrar el botón de decodificación una vez que se haya terminado el proceso de decodificar
    global boton_ver_decodificado
    estilos = crear_estilos()
    
    frame_botones = Frame(root, **estilos['frame'])
    frame_botones.pack(pady=20)
    
    boton_decodificar = Button(frame_botones, text="Decodificar", command=decodificar, **estilos['boton_principal'])
    boton_decodificar.grid(row=0, column=0, padx=10)
    configurar_hover(boton_decodificar, COLORES['principal'], COLORES['principal_hover'])
    
    boton_ver_decodificado = Button(frame_botones, text="Ver Código Decodificado", 
                                  command=mostrar_decodificado, **estilos['boton_principal'])
    boton_ver_decodificado.grid(row=0, column=1, padx=10)
    configurar_hover(boton_ver_decodificado, COLORES['principal'], COLORES['principal_hover'])
    boton_ver_decodificado.grid_remove()


def mostrar_decodificado():
    limpiar_frame(root)
    estilos = crear_estilos()
    
    root.configure(bg=COLORES['fondo'])
    
    # Frame superior con botón volver
    frame_superior = Frame(root, **estilos['frame'])
    frame_superior.pack(fill=X)
    
    boton_volver = Button(frame_superior, text="← Volver", command=reconstruir_interfaz, **estilos['boton_secundario'])
    boton_volver.pack(side=LEFT)
    configurar_hover(boton_volver, COLORES['secundario'], COLORES['secundario_hover'])
    
    # Frame principal
    frame_principal = Frame(root, **estilos['frame'])
    frame_principal.pack(fill=BOTH, expand=True)
    
    Label(frame_principal, text="Código Decodificado", **estilos['label']).pack(pady=(0, 10))
    
    # Frame del texto con borde
    frame_texto = Frame(frame_principal, **estilos['frame_borde'])
    frame_texto.pack(fill=BOTH, expand=True)
    
    # Área de texto
    text_decodificado = Text(frame_texto, **estilos['texto'])
    text_decodificado.pack(side=LEFT, fill=BOTH, expand=True, padx=1, pady=1)
    
    # Scrollbar
    scroll_y = Scrollbar(frame_texto, orient=VERTICAL, command=text_decodificado.yview)
    scroll_y.pack(side=RIGHT, fill=Y)
    text_decodificado.config(yscrollcommand=scroll_y.set)
    
    # Configurar scrollbar
    scroll_y.config(
        troughcolor=COLORES['panel'],
        bg=COLORES['borde'],
        activebackground=COLORES['principal']
    )
    
    # Insertar contenido
    for item in instrucciones_decodificadas:
        text_decodificado.insert(END, item + "\n")
    
    text_decodificado.config(state=DISABLED)

# Crear la ventana principal
root = Tk()
root.geometry("800x500")
root.title("Decodificador de Ensamblador")

# Construir la interfaz inicial
reconstruir_interfaz()

root.mainloop()