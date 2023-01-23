# 1º LDM

## HTML

CSSstub

```css
<style>
## class col dentro de class row en div cuya clase empieza por col* .row>.col,div[class^="col"]{
    **    **padding-top: .75rem;
    **    **padding-bottom: .75rem;
    **    **background-color: rgba(39, 41, 43, 0.03);
    **    **border: 1px solid rgba(28, 28, 29, 0.1)**    **;
    border-radius: 10px;
    }
</style>
```

## JS

```
<script src="main.js"></script>
```

### script:

```
let test = “Test” // var numero = 12 # Variable let o var
const COLOR_ROJO = “#FF0000” # Constante
alert (“Hola” + test + numero) # alerta muestra Hola + variable test + var numero
console.log(*variable*) # muestra por consola la variable que se ponga
```

### recoge elemento contenido por id

```
const contenido = document.getElementById("contenido")
contenido.innerHTML="Hola" # pone "hola" en el div con ID = contenido
```

### cambiar contenido desde JS a HTML, introduce divs

```
contenido.innerHTML="<div>"+nombre+"</div>"; == `<div>$ {nombre}</div>`
contenido.innerHTML +="<div>"+edad+"</div>"; # Concatenar
```

### Condiciones

#### if

```
var condicion=21;
var condicio2=22;
if(condicion=21) {
alert("Correcto");
}else {
alert("falso");
}elseif(condicio2=22) {
alert("tmb correcto");
}
```

#### for

```
for(var i = 0; i <= 10; i++){ # i = x; mientras i <= 10; i=i+1 // cada ejecución
contenido.innerHTML +=`<div>Edad: ${i} años</div>`;
}
```

#### Functions

```html
function addContent(newContent){ contenido.innerHTML += newContent; }
addContent("Holaa");
<!--  al ejecutar addContent Holaa es el newContent y se inserta -->
```

#### Arrays

```
var edades = [23, 45, 2, 42];
console.log(array[3]);
> Juntar con bucles
for(var i = 0; i < edades.length; i++){
addContent(`<div>Edad: ${edades[i]} años</div>`);
}
```

### Botón

```html
<button class="btn" id="boton">Ajax</button> # con el enlace a JS
document.querySelector('#boton').addEventListener('click',traerDatos); function
traerDatos(){ console.log('funcion activada'); }
```

### [AJAX](https://www.w3schools.com/js/js_ajax_intro.asp)

```
function traerDatos(){
    const xhttp = new XMLHttpRequest();
    xhttp.open('GET','text.txt', true);
    xhttp.send();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){ ESTADOS
        console.log(this.responseText);
        }
    }
}
```

### [BOOTSTRAP](https://getbootstrap.com/docs/5.0/getting-started/introduction/)

```html
<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
...
</head>
<body>
...
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJh GGScy+8" crossorigin="anonymous"></script>
</body>
```

---

# 1º ISO

## Arranque

### Windows

#### Sistema

```bash
Compmgmt.msc # Administración de usuarios y grupos locales⤵
lusrmgr.msc # Para administrar rapidamente os usuarios
shell:startup / shell:common startup # Usuario / Todos
Devmgmt.msc # Administrador de Dispositivos
systeminfo # info hardware
sigverif # comprobar firma
```

#### CD

##### WINDOWS

```
SO ( WIN 7 )
> shift+f10

diskpart
list disk 
select disk 0 
list partition > clean 
( help create 
partition ( Primary ) 
create partition primary size=” ” 
List 
Partition -->select partition 1 
active
```

##### System Rescue CD

```
SO (Win XP)
CD : System Rescue Cd > 1 
startx
partition
boot xp // hidden Win7
V2C47-MK7JD-3R89F-D2KXW-VPK3J
```

#### Menu arranque Windows

##### XP

```
Disco local > Mostrar todo
boot.ini
MBR = Primer sector do disco duro
```

##### Win 7 +

```
Win 7
Cmd → system32
```

![](https://i.imgur.com/sX8SZPB.png)

### BCD

#### Regenerar BCD

```bash
Bcdboot C:\windows /s C: # Rexeneramos o arranque do Windows da 2º partición
Bootrec /Fixboot # Rexeneramos o Sector de arranque da partición
Bootrec /scanos # Rexeneramos o arquivo BCD
```

#### Clonar y restaurar

##### Clonar I ( copia de seguridad )

```bash
fdisk -l # Comprobar que o detecta o sistema
cfdisk /dev/sd(b) # Crear particiones desde cfdisk, de tipo 2
mkfs -t ext4 /dev/sdb1 # Formatear en ext4
mount /dev/sdb1 /mnt # Montar sdb1 en mnt
sfdisk -d /dev/sda /mnt/tp.bak # Facer copia de seguirdade da táboa de particións

dd if=/dev/sda of=/mnt/mbr.bak bs=512 count=1 // Copia 1º sector HD
```

##### Restaurar I

```bash
mount /dev/sdb1 /mnt # Montar o disco duro de imaxes en /mnt
Nano /mnt/boot.ini # editar boot.ini
sfdisk /dev/sda < /mnt/tp.bak # Restaurar copia de seguridade
```

##### Clonar II

```bash
mount | grep sd # filtra e amosa palabras que componen "sd"
umount /mnt
mount | grep sd
mount /dev/sdb1 /mnt
```

###### Linux

```bash
fsarchiver restfs /mnt/debianSistema.fsa id=0,dest=/dev/sdaX
mkswap /dev/sdaX
```

###### Windows

```bash
partclone.ntfs -c -s /dev/sda1 -o /mnt/win7.img
partclone.ntfs -c -s /dev/sda2 -o /mnt/winXP.img
```

##### Restauracion II

```bash
mount /dev/sdb1 /mnt
cfdisk /dev/sda
partclone.ntfs -r -s /mnt/winX.img -o /dev/sdaX
```

###### Win CD

```bash
bcdedit
bootrec /fixmbr
bootrec /rebuildbcd
```

###### Linux

```bash
fsarchiver restfs /mnt/debianSistema.fsa id=0,dest=/dev/sdaX
mkswap /dev/sdaX

mount /dev/sdaX /mnt
nano /mnt/etc/fstab
umount /mnt

> CD debian > advanced > modo rescate > Restaurar GRUB > 
grub.Install /dev/sda > update-gru
```

##### Clonar III

Configuracion inicio (p 11)
Facer imaxe
&nbsp;&nbsp; Intento 1 (p 13)
&nbsp;&nbsp;&nbsp;&nbsp; Sysprep
&nbsp;&nbsp;&nbsp;&nbsp; Restauro
&nbsp;&nbsp;&nbsp;&nbsp; Problema pregunta cambios
&nbsp;&nbsp; Intento 2 Sysprep arquivo respostas (p 17)
&nbsp;&nbsp;&nbsp;&nbsp; Fago sysprep respostas
&nbsp;&nbsp;&nbsp;&nbsp; Restauro
&nbsp;&nbsp;&nbsp;&nbsp; Problema :config dos usuarios
&nbsp;&nbsp; Sysprep con bat
&nbsp;&nbsp;&nbsp;&nbsp; creo BAT
&nbsp;&nbsp;&nbsp;&nbsp; sysprep config
&nbsp;&nbsp;&nbsp;&nbsp; Reinicio == Solucionado

## LINUX AVANZADO

### GRUB

```bash
/etc/grub.d # no modificar
/etc/default/grub
update-grub
etc/grub.d # archivos editar (editar 40_custom, quitar permisos 30_os-pr)
```

### APT

#### REPOS

```bash
/nvim /etc/apt/sources.list
```

```bash
#
Tipo paquete Url Repositorio Version Debian Sección
deb http://deb.debian.org/debian buster main
deb-src http://ftp.es.debian.org/debian testing main
#deb-src http://deb.debian.org/debian stable main
deb http://deb.debian.org/debian buster-backports main
deb http://deb.debian.org/debian-securirty buster/updates main
```

```bash
mkdir ~/src
cd ~/src
apt-get source "package"
apt-get install build-essential
apt-get -t buster-backports install "package
```

### INSTALAR SERVIDOR X

```bash
apt install xorg
xmayland # Servidor X
startx
```

#### GESTOR DE VENTANAS

```bash
apt-cache search window manager | grep "window manager"
apt install wmaker // icewm // e17 // Gestores de ventanas
apt install lxde // xfce4 // mate // gnome // Entorno de escritorio
apt install xdm // wdm // lightdm // Display Manager # gestor login
dpkg-reconfigure xdm # Cambiar Gestor Login
```

### USUARIOS

```bash
whoami
Passwd
cat/etc/Passwd
vim /etc/shadow

shadowconfig on ⇔ off
```

adduser ⇔ useradd
deluser
usermod

#### Group

```bash
groupmod -g gid nomegrupo # Cambiar GID
groupmod -n NuevoNombre NombreGrupo # Cambiar nombre
groupmod -G (Principal) -g (Secundario) NombreGrupo User
groups usuario # Grupos del usuario
```

##### GPASSWD

```bash
gpasswd -A usuario grupo # Convertir en admin
gpasswd -M " " # Quitar Admin
gpasswd grupo # Establecer contraseña grupo
gpasswd -r grupo # Quitar contraseña
gpasswd -a usuario group # Añadir miembros
gpasswd -d " " # Eliminar miembro
```

##### ACL SETFACL

```bash
setfacl -m group:grupo2:rwx /dir1 # Permisos Grupo
setfacl -m user:usuario:rwx /dir1 # Permisos User
setfacl -x user:usuario /dir1 # Elimina user
setfacl -R # Cambia permisos de forma recursiva
setfacl -b # Borra permisos conserva UGO
```

```
/etc/skel #ficheros/directorios que se copian en home de un nuevo usuario
```

### COMPRIMIR

#### GZIP

```bash
gzip test # Comprime archivo
gzip -l test.gz # Muestra ratio de compresión
gunzip test.gz ⇔ gzip -d test.gz # Descomprime
```

gzip solo comprime un archivo

#### TAR

TAR COMPRIME VARIOS A UNO -- GZIP COMPRIME UNO

```bash
tar [options(c/x/t/r/v/f)] archivos
```

#### JUNTAR TAR+GZ

```bash
tar czf test.tar.gz archivos ← Comprimir
tar xzf test.tar.gz ← Descomprimir
```

### COPIAS DE SEGURIDAD

```
rdiff-backup ORIGEN/ COPIA/ # Hacer copia de seguridad
rdiff-backup -l COPIA/ # Listar copias
rdiff-backup -r NombreCopia COPIA/ RESTAURADOS/ # Restaurar copia
```

### SYSTEMD

```bash
systemd-analyze (blame) # tiempo que tarda en arrancar (por servicio)
systemctl status Nombre # Info servicio
systemctl start/stop Nombre
```

`/lib/systemd/system/service.service` ← Ruta servicios

`journalctl` ← Logs sistema

### SIST. ARCHIVOS

#### PARTICIONAR

```bash
cfdisk
```

#### FORMATEAR

```bash
apt install mkfs-x
mkfs -t vfat -L DATOS /dev/sdx ⇔ mkfs.vfat # FAT32
mkfs -t ext4 -L NOMBRE /dev/sdx ⇔ mkfs.ext4 # EXT4
mkfs -t ntfs -f -L NOMBRE /dev/sdx ⇔ mkfs.ntfs # NTFS
```

##### MOUNT SOLO ROOT

```bash
nvim /etc/fstab

/dev/sda3 /mnt/win ntfs defaults 0 0

blkid # Conocer ID
```

#### NFS

```bash
apt install nfs-common # Cliente
apt install nfs-kernel-server # servidor
ss -4ta | grep nfs ⇔ ss -4ta | grep 2049 # Escuchar puertos
```

##### añadir carpetas

```bash
vim /etc/exports

/srv/compartida1 192.168.63.4(ro)
/srv/compartida2 192.168.0.0/255.255.0.0(rw)

systemctl restart nfs-kernel-server
mount -t nfs 192.168.63.100:/compartida /mnt/remota
```

#### Cuotas

```bash
vim /etc/fstab

/dev/sdax / ext4 defaults,errors=remount-ro,usrquota,grpquota 0 1

mount -o remount / # Remontar sin reboot
quotacheck -cugm / # Activar (si no reiniciamos)
quotaon / ⇔ quotaoff / # Habilitar ⇔ deshabilitar
repquota -a # Comprobar establecido en cuotas
```

##### Asignar cuotas

```bash
edquota -u user # usuarios
edquota -g group # Grupo
```

## Windows avanzado

### REGISTRO

> El Registro es una base de datos que contiene toda la información de
> configuración de Windows. En él se incluye absolutamente todo, desde las
> opciones de pantalla hasta las contraseñas de usuario.
> La información del Registro se organiza por categorías
> El Registro está organizado en una estructura jerárquica, compuesta por
> subárboles con sus respectivas claves, subclaves y entradas de valor
> se almacena en archivos binarios en disco
> cada elemento del Registro tiene un propietario,ACL y controles de auditoría

#### HKLM

> hardware, software , SO
> Memoria del sistema,controladores de dispositivos y datos de control

#### HKCR

> asociaciones de archivos
> También contiene la base de datos del registro OLE, el antiguo
> REG.DAT de Win 3.x

#### HKCU

> perfil del usuario que ha iniciado la sesión actual
> incluye las variables de entorno, la configuración del escritorio, las
> conexiones, impresoras y las preferencias para los programa

#### HKU

> Contiene una entrada para cada usuario que haya iniciado una sesión
> previamente en la computadora
> usuarios con acceso remoto al servidor no tienen perfiles en esta
> clave del servidor. Sus perfiles se cargan en el Registro de sus propios equipos

#### HKCF

> configuración de hardware del equipo local al iniciarse
> configurar opciones como los controladores de dispositivo resolución
> de pantalla

### REGEDIT

`HKCU\Software\Microsoft\Windows\CurrentVersion\Run` ← Quitar permisos.

`Process monitor.exe` ← Ver registro en tiempo real

`Operation: RegSetValue ← Jump to` ← Buscar donde cambian los valores / ir

`@echo off` ← crear .bat para ejecutarlo

`reg add HKCU\Software\microsft\notepad /v 1fFaceName /d “MV Boli” /f >nul`

mostrar todo en en carpeta > cargar subinterfaz > `NTUSER.DAT` ← añadir usuario a HKU

### SERVICIOS

> Los servicios son procesos que se ejecutan de forma automática al iniciar Windows y quedan residentes en memoria, proporcionando diversas funcionalidades con la mínima intervención del usuario.
> Proceso → Programa en ejecución Programa → archivo en el Disco Duro Programa (HD) → Proceso (RAM)

### VISOR DE EVENTOS

```bash
COMPMGMT.MSC # Visor de Eventos
Crear vista personalizada por origen # Crear regla
Vista personalizada > nombre > Guardar todos los eventos...
Secpol > Directivas locales > directiva de auditoría > objetos > activar →
carpeta > seguridad > Op Av > activar auditoría
```

### CUOTAS

> HABILITAR TODO VALORES DE CUOTRA = EDITAR CADA USUARIO

### ENCRIPTAR

```bash
PROPIEDADES > Atrib Avanzados > # Cifrar contenido para proteger datos 
> CERTMGR.MSC > ver claves ( y exportar)
```

# 2º ASO

## DOCKER

```bash
docker run --name webserver01 -d -p 8080:80 httpd
docker run --name webserver02 -v /origen:/destino -d -p 8081:80 httpd
docker exec -ti webserver02 /bin/bash # ejecutrar terminal en el contenedor
docker tag debian-ssh:latest debian-ssh:1 # cambiar etiqueta imaxe
echo "root:$ROOT_PASSWORD" | chpasswd # cambiar contraseña (para script .sh)
docker build -t debian-ssh:1 . ⇔ /*/debian/dockerfile # construir la imagen
docker run --name pass -d -p 2200:22 -e ROOT_PASSWORD=abc123. debian-ssh:1
```

### DOCKER MACHINE

```bash
docker-machine create -d virtualbox hostX
docker-machine ssh hostX "docker swarm init --advertise-addr x.x.x.x"
docker swarm join ..token # iniciamos swarm ⇔ saca un token
docker-machine ssh host02 "docker swarm join... # unimos la otra máquina
docker-machine env host01 # desplegar aplicación
eval $(docker-machine env host01) # ejecutamos en el host el commando
docker stack deploy --compose-file docker-compose.yml wordpress
```

## BIND

## LDAP

```bash
apt-get install slapd
ldapsearch -x -b 'dc=breogan,dc=local' # buscar
ldapadd -D cn=admin,dc=breogan,dc=local -W -f X.ldif # añadir archivo
```

### CONFIGURACION PARA AÑADIR A LA MAQUINA

```bash
apt-get install libpam-ldapd
```

### SCRIPTS

```bash
apt-get install ldapscripts
ldapadd...
```

![](https://i.imgur.com/mdu1mzH.png)

# 1º FH

## RASPBERRY PI

### Montar SO

```bash
Fdisk -l /dev/sdg
umount /dev/sdg1 mount | grep sdg
dd if=/ruta archivo of=/dev/sdg bs=4M
```

### Conf red

```bash
mount /dev/sdg2 /mnt
vim /mnt/etc/dhcpcd.conf

Interface eth0
Static ip_address=172.20.4.64/16
Static routers=172.20.2.1
Static domain_name_server=172.20.0.7 8.8.8.8

umount /mnt
mount /dev/sdg1 /mnt
touch /mnt/ssh
```

### Raspberry

```bash
ssh pi@[ip]
raspi-config
fsck /dev/sdx1-2 # reparar sist arch
```

# 1º PAR

## CISCO

### VLAN

```bash
(config)#VLAN X
(config-if)#name NAME
(config-if)#exit
(config)#interface VLANX
(config-if)#ip address <ip><mask>
(config-if)#no shutdown
(config-if)#exit
(config)#interface fa0/x ⇔ interface range fa0/x-y
(config-if)#switchport access vlan X
```

### Crear subinterfaces

```
(config)#interface gig0/0.10
(config-subif)#encapsulation dot1Q 10
(config-subif)#ip address <ip><mask>

(config)#interface gig0/x
S1(config-if)#switchport mode trunk
```

### contraseñas:

```
(config)#enable password cisco
(config)#enable password cisco2

(config-line)#password cisco
(config-line)#login
(config)#line vty 0 15
(config-line)#password cisco
(config-line)#login
(config)#service password-encryption
```

### SSH

```
Telnet <ip> ## entrar en el router desde PC
#show running-config // comprobar contraseñas
(config)#service password-encryption // cifrar contraseñas
```

### Cifrar comunicaciones

```
(config)#ip domain-name netacad.pkt // Conf nombre dominio
(config)#crypto key generate rsa // Genera claves seguras
(config)#username administrator secret cisco // Crear usuario para SSH
(config)#line vty 0 15 // Conf VTY admita solo SSH
(config-line)#transport input ssh
(config-line)#login local
(config-line)#no password cisco
ssh -l administrator <ip>
```

### ACL

> Declarar reglas,se van poniendo de 10 en 10 por si se añaden más.

```
10 deny 192.168.10.0 0.0.0.255
20 permit any
```

> - permitir tráfico de un pc con la ip 192.168.10.12, red 192.168.10.0,
> - añadir una regla antes de la 10 donde indicamos la ip y la máscara al
>   especificar un host concreto queda con todo ceros (0.0.0.0) quedando así:

```
9 permit 192.168.10.12 0.0.0.0
10 deny 192.168.10.0 0.0.0.255
20 permit any
R1(config)#no access-list 1
R1(config)#access-list 1 deny host <ip>
R1(config)#access-list 1 permit <ip> <mask (0.0.0.255)>
R1(config)#interface s0/0/0
R1(config)#ip access-group 1 out
```

![](https://i.imgur.com/0dEJfrV.png)
![](https://i.imgur.com/W3xBLzE.png)

# 2º SRI

www.microsoft.com. . = root hints

. |  | . | .com | | . | www | |
---------|----------|---------|---------|---------|---------|---------|---------|
.com | IP | > | microsoft.com | IP | > | www.microsoft.com | 10.25.45.50
.net | IP | . | telefonica.com | IP | . |  | 
.es  | IP | . |  |  | . |  |

## DNS

```bash
/etc/network/interfaces # cambiar ip en cliente y Router
/etc/resolv.conf 8.8.8.8 # cambiar DNS para instalar
Apt install dnsutils ⇔ Apt install tshark
Admin servidor Administrar agregar roles/características roles servidor DNS
liente cambiar dns
nslookup [direccion] # devolve dirección IP
dig@[IP] # devolve o nome
```

### LINUX

```bash
/etc/network/interfaces /etc/resolv.conf # cambiar ip e DNS
/etc/hosts /etc/hostname # cambiar nome máquina
apt install bind9
apt install tshark dnsutils # instalar utilidades
/etc/bind # ficheros de configuración BIND9
/etc/bind/named.conf.local # crear zonas locales de resolución, 2 archivos incluyen las entradas para zona de resolución directa e inversa (hay que crearlos)

zone "example.com" {
    type master;
    file "db.example.com";
};
zone "X.168.192.in-addr.arpa" {
    type master;
    file "db.192.168.X";
};

/var/cache/bind # Crear archivos db.example.com db.192.168.X
-rw-rw---- 1 bind bind 313 mar 14 16:25 db.192.168.X # Cambiar permisos
```

### Directa

```bash
vim /var/cache/bind/db.example.com // directa
```

```bash
$ORIGIN 2.168.192.in-addr.arpa.
$TTL 86400 ; 1 day
    @ IN SOA avatar hostmaster(
    1 ; serial
    21600 ; refresh
    3600 ; retry (1 week)
    604800 ; expire
    21600 ; minimum (6 hours)
)
@ IN NS avatar.example.com.
1 IN PTR avatar.example.com.
```

![](https://i.imgur.com/YuHejNP.png)

### Inversa

```bash
vim /var/cache/bind/db.192.168.X // inversa
```

```bash
$ORIGIN 2.168.192.in-addr.arpa.
$TTL 86400 ; 1 day
@ IN SOA avatar hostmaster(
    1 ; serial
    21600 ; refresh
    3600 ; retry (1 week)
    604800 ; expire
    21600 ; minimum (6 hours)
)
@ IN NS avatar.example.com.
1 IN PTR avatar.example.com.
```

```bash
/etc/init.d/bind9 restart ⇔ systemctl restart bind9
```

![](https://i.imgur.com/RQL7WBX.png)

### FORWARDERS

```bash
vim /etc/bind/named.conf.local
```

```bash
zone "other.sri"{
type forward;
forwarders {192.168.X.X}; // DNS
};
```

![](https://i.imgur.com/6T83AeN.png)

```bash
vim /etc/bind/named.conf.options
```

```bash
options {
    directory "/var/cache/bind";
    dnssec-validation no;
    dnssec-enable no;
    forward only;
};
```

![](https://i.imgur.com/pBrFlSO.png)

### MAESTRO ESCLAVO

```bash
vim /etc/bind/named.conf.options
```

```bash
options{
    allow-transfer {none;};
    ...
```

```bash
vim /etc/bind/named.conf.local
zone "X" {
    ...
    allow-transfer{x.x.x.x;}; ← IP DNS secundario
    notify yes;
```

```bash
vim /var/cache/bind/db.x.x.x
```

```bash
...                         ...
@   IN  NS  ns2.name.sri.   =
```

```bash
vim /var/cache/bind/db.name.sri
```

```bash
...                             ...
ns2 IN  A   x.x.x.x (IP DNS 2)  5   IN  PTR     ns2.*
```

```bash
vim /etc/bind/named.conf.local
```

```bash
zone "X" {
    type eslave;
    file "db.name.sri"; 
    masters {x.x.x.x;}; (IP DNS 1)
}
```

### SUBDOMINIO VIRTUAL

```bash
vim /var/cache/bind/db.nome.sri # modificar para añadir ns3
```

```bash
...
$ORIGIN es.example.sri.
@   IN  NS  ns3
ns3 IN  A   x.x.x.x
```

![](https://i.imgur.com/kmypDwc.png)

```bash
vim /etc/bind/noamed.conf.local # añadir el subdominio
```

```bash
zone "es.example.sri" {
    type master;
    file "db.es.example.sri";
};
```

```bash
vim /var/cache/bind/db.es.nome.sri # crear
```

```bash
masters {x.x.x.x};
    file "informatica.example.com";
};
```

![](https://i.imgur.com/RLxsRmP.png)

![](https://i.imgur.com/4a0L27c.png)

### STUB

```bash
zone "informatica.example.com" {
    type stub;
    masters {x.x.x.x};
    file "informatica.example.com";
};
```

![](https://i.imgur.com/sm22Pdd.png)

### VISTAS

`/etc/bind/named.conf.local`

#### crar ACL

##### vista interna

zone: name.sri

&nbsp;&nbsp;&nbsp;&nbsp; db.int.name.sri

zone: x.x.x.in... .sri

&nbsp;&nbsp;&nbsp;&nbsp; db.int.x.x.x

##### vista externa

zone: name.sri

&nbsp;&nbsp;&nbsp;&nbsp; db.ext.name.sri

zone y.y.y.in... .sri

&nbsp;&nbsp;&nbsp;&nbsp; db.ext.y.y.y

`/var/cache/bind/db.int.name.sri`

![](https://i.imgur.com/h2Th47p.png)

`/var/cache/bind/db.int.x.x.x `

![](https://i.imgur.com/eOzgOmh.png)

`/var/cache/bind/db.ext.name.sri`

![](https://i.imgur.com/xKQYXCw.png)

`/var/cache/bind/db.ext.y.y.y`

![](https://i.imgur.com/Bo0n04g.png)

### DHCP

![](https://i.imgur.com/yQk1G0x.png)

```bash
apt-get install isc-dhcp-server
vim /etc/default/isc-dhcp-server // archivo conf
```

### SUBNET

```bash
/etc/defaults/isc-dhcp-server
```

ASIGNAR IP FIJA MEDIANTE MAC

![](https://i.imgur.com/2hPXTq8.png)

![](https://i.imgur.com/lVrSp3h.png)

### ACTIVAR ROUTER FORWARD

```bash
/etc/network/interfaces
```

![](https://i.imgur.com/nRcIFxH.png)

### DDNS

#### DNS

`/etc/bind/named.conf`

![](https://i.imgur.com/qDzlvxY.png)

`/etc/bind/named.conf.local`

![](https://i.imgur.com/jfqAl29.png)

#### DHCP

`/etc/dhcp/dhcpd.conf`

![](https://i.imgur.com/jgTBdsP.png)

![](https://i.imgur.com/xQfH5n3.png)

### SERVIDOR WEB

#### APACHE

##### CONFIGURAR DNS

![](https://i.imgur.com/ZoypzrU.png)

![](https://i.imgur.com/MGmmBJ1.png)

![](https://i.imgur.com/rQxW8R4.png)

![](https://i.imgur.com/QbGFOlh.png)

##### CONF APACHE

```bash
vim /etc/apache2/sites-available 
cp 000-default.conf new.conf // crear archivo conf
chmod a+x new.conf // chmod a-x 000...conf 
a2ensite new // crear ligacion simbolica 
mkdir /var/www/new
chown -R www-data:www-data /var/www/new
```

![](https://i.imgur.com/chMopez.png)

# 2º SAD

## Crear puente

```bash
brctl addbr LAN # crear un puente LAN
ip link set LAN up # activar
ip a s # ver
ip addr del 172.20.3.3/16 dev eth0 # eliminar la ip de eth0 (se pierde la conexión)
ip addr add 172.20.3.3/16 dev LAN # añadir la ip a LAN
brctl addif LAN eth0 # añadir la interfaz eth0 a LAN
brctl show
ip route show
ip route add default via 172.20.0.1 # volver a añadir la ip y recuperar la conexión /proc/sys/net/ipv4/ip_forward
```

### Crear puente en el arranque

![](https://i.imgur.com/Zi93Lhk.png)

![](https://i.imgur.com/SnRenTz.png)

### MV + SCRIPT

```bash
Qemu-img create -fqcow2 -b /var/lib/libvirt/templates/console -f row
encrypt-fs
```

Crear debian en maquina > conectar por ssh

```bash
ssh key-gen # Generar pareja de claves publicas y privadas
~/.ssh/authorized_keys # Crear carpeta en ~ Root
```

```bash
sed -i "s/viejo/nuevo/g" ruta # sustituir
ip route ver # tabla de rutas (gateway)
ip route | grep default | cut -d ' ' -f3 # saca gateway con filtros (se pueden poner en variables)
```

```bash
apt install encfs
mkdir privado y .privado # 2 carpetas
encfs .privado privado # (ruta completa)
```

```bash
apt install pam_mount
vim /etc/security/pam_mount.conf.xml # configurar montaje
```

```bash
<volume user="usuario" pstype="fuse" path="encfs#/home/%(USER)/.ofye" mountpoint="/home/%(USER)/pd" options="nonempaty" />
```

## conf network

```bash
ip addr del 172.20.200.174/16 dev enp1s0
ip route show
ip route del defaults
ip route add default via 192.168.122.1
```

## cryptsetup

### abrir unidad

```bash
cryptsetup luksFormat /dev/X # Crea cabeceira LUKS cos datos sobre o cifrado
cryptsetup open /dev/X Nombre
```

## abrir ssh

```bash
iptables -t nat -a PREROUTING -p tcp --dport 23 -j DNAT --to-destination DestIP:22
ssh -L 8080:www.google.es:80 user@ip -p23 # tunel directo
ssh - 8080:192.168.3.1:22 user@ip -p23 # tunel in
```

# 1º XBD

CREATE                  CREATE TABLE nome ( );
DROP
ALTER
DESC
Number → 3 cifras = Number(3) -999 a 999 // 3 cifras 2 decimas = Number (3,2) 1,23
Varchar
Date
Char → DNI = char(9)

| Clientes |  | Telefono |
| --- | --- | --- |
| Cod [PK] | <---> | Cod_C [PK] |
| nome[NN][U] |  | Telf |
| idade |

```sql
Create table CLIENTES (
    Cod number,
    Nome varchar2 (64), # Reduce tamaño
    Idade number
);
```

CONSTRAINTS = [PK][NN][U]

```sql
Create table Clientes (                     Create table Clientes (
    Cod number PRIMARY KEY,                     cod number
    Nome varchar2 (64) NOT NULL UNIQUE,         nome varchar2 (64) NOT NULL
    Idade number                                idade number,
);                                              PRIMARY KEY(cod),
                                                UNIQUE(nome)
                                            );

                    CONSTRAINT “nome” “tipo” (campo,campo2,...)
                        Create table Clientes (
                        Cod number,
                        Nome varchar2 (64) NOT NULL,
                        Idade number,
                        Constraint cli_PK Primary Key (cod),
                        Constraint cli_U Unique (nome)
                    );
```

```sql
Create table Teléfono (
    Cod_c number,
    Telf varchar2 (32),
    Constraint telf_PK Primary Key (cod_telf),
    Constraint tel_FL Foreign Key (Cod_c) REFERENCES clientes (cod)
)
    <==>
    Create table Teléfonos (
    Cod_c number,
    Telf varchar2 (32),
    Constraint telf_PK Primary Key (cod_telf)
)
Alter table Teléfonos
    ADD Constraint tel_FL Foreign Key (Cod_c) REFERENCES clientes (cod);
DROP table Clientes
CASCADE constraints;
```

DESC = da los campos de la tabla
ALTER = Alterar tabla
DROP = Borrar columna
RENAME = renombrar columna
DESC nome;
Alter Table nome

* Modify Idade number;
* Drop column nome_columna cascade constraints;
* Rename column nome_columna TO nuevo_nombre,

| . | . | . |
| --- | --- | --- |
| CREATE | INSERT | Tuplas |
| DROP | DELETE | Tuplas |
| ALTER | UPDATE | Campo |
| DESCRIBE | SELECT | |

```sql
Insert into clientes (DNI, nome, enderzo, email)
Values (1,’Pepe’,’rua de ...’,’pepe@gmail.com’) ;

Delete from clientes where [cod =3];

Update clientes set campo=valor where [condición];
Select campo1,campo2,       Select nombre, apellido
    From tabla              from empleados
    Where [Condición];      where departamento=10;

NOT (idade=20) ⇔ idade <> 20
NOT(idade=20 AND dep_id<>21) ⇔ NOT idade=20 OR dep_id=21
(idade=20 OR idade=30) AND cidade=’Madrid’ ⇔ where idade IN(20,30,40) AND
cidade=’x’;
idade>=18 AND idade <=80 ⇔ idade between 18 AND 80
```
