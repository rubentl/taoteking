package;

import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.TextFieldAutoSize;
import flash.display.MovieClip;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.events.MouseEvent;
import flash.events.FullScreenEvent;
import flash.events.KeyboardEvent;
import flash.utils.Timer;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.display.Loader;
import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import caurina.transitions.Tweener;
import caurina.transitions.properties.DisplayShortcuts;
import caurina.transitions.properties.ColorShortcuts;


class Niebla extends Bitmap {public function new(){super();}}
class Chino extends Bitmap {public function new(){super();}}
class TaoTeKing extends Bitmap {public function new(){super();}}
class WenTzu extends Bitmap {public function new(){super();}}
class HuaHuChing extends Bitmap {public function new(){super();}}
class Fullscr extends Bitmap {public function new(){super();}}

//---------------------------------------------------------------------------- Clase Ventana
// Ventana donde se muestra el texto del libro.
class Ventana extends Sprite {

    var texTao:TextField;  // texto del taoteking
    var texHua:TextField;  // texto del huahuching
    var texWen:TextField;  // texto del wentzu
    var activo:TextField;  // texto activo en un momento dado 
    var flechaArriba:Sprite;  // boton para subir el texto 
    var flechaAbajo:Sprite;   // texto para bajar el texto

    public function new(){
        super();
        graphics.beginFill(0xffffff);
        graphics.drawRoundRect(0,0,500,460,50);
        graphics.endFill();
        alpha = 0;
        name = "Ventana";
        width = height = 10;
        visible = false;
        addEventListener(KeyboardEvent.KEY_DOWN,scrollv);
        flechaArriba = new Sprite();
        flechaArriba.graphics.beginFill(0xffffff);
        flechaArriba.graphics.drawRoundRect(510,10,30,30,10);
        flechaArriba.graphics.endFill();
        flechaArriba.graphics.lineStyle(4,0x000000);
        flechaArriba.graphics.moveTo(515,25);
        flechaArriba.graphics.lineTo(525,15);
        flechaArriba.graphics.lineTo(535,25);
        flechaArriba.graphics.moveTo(515,35);
        flechaArriba.graphics.lineTo(525,25);
        flechaArriba.graphics.lineTo(535,35);
        flechaArriba.alpha = 0.6;
        addChild(flechaArriba);
        flechaArriba.addEventListener(MouseEvent.MOUSE_DOWN, arribaDOWN);
        flechaArriba.addEventListener(MouseEvent.ROLL_OVER, arribaMouseOVER);
        flechaArriba.addEventListener(MouseEvent.ROLL_OUT, arribaMouseOUT);
        flechaAbajo = new Sprite();
        flechaAbajo.graphics.beginFill(0xffffff);
        flechaAbajo.graphics.drawRoundRect(510,60,30,30,10);
        flechaAbajo.graphics.endFill();
        flechaAbajo.graphics.lineStyle(4,0x000000);
        flechaAbajo.graphics.moveTo(515,65);
        flechaAbajo.graphics.lineTo(525,75);
        flechaAbajo.graphics.lineTo(535,65);
        flechaAbajo.graphics.moveTo(515,75);
        flechaAbajo.graphics.lineTo(525,85);
        flechaAbajo.graphics.lineTo(535,75);
        flechaAbajo.alpha = 0.6;
        addChild(flechaAbajo);
        flechaAbajo.addEventListener(MouseEvent.MOUSE_DOWN, abajoDOWN);
        flechaAbajo.addEventListener(MouseEvent.ROLL_OVER, abajoMouseOVER);
        flechaAbajo.addEventListener(MouseEvent.ROLL_OUT, abajoMouseOUT);
    }
    function abajoMouseOUT(ev:MouseEvent){
        ev.currentTarget.filters = [];
    }
    function abajoMouseOVER(ev:MouseEvent){
        ev.currentTarget.filters = [new DropShadowFilter(5,20,0x000000)];
    }
    function arribaMouseOUT(ev:MouseEvent){
        ev.currentTarget.filters = [];
    }
    function arribaMouseOVER(ev:MouseEvent){
        ev.currentTarget.filters = [new DropShadowFilter(5,20,0x000000)];
    }
    function arribaDOWN(ev:MouseEvent){
        if ( activo != null ) activo.scrollV -= 10;
    }
    function abajoDOWN(ev:MouseEvent){
        if ( activo != null ) activo.scrollV += 10;
    }
    function scrollv(ev:KeyboardEvent){
        if (activo != null){
            switch ( ev.keyCode ){
                case 40: activo.scrollV++;
                case 38: activo.scrollV--;
                case 33: activo.scrollV -= 10;
                case 34: activo.scrollV += 10;
            }
        }
    }
    public function setTexto(btn:Btn){  // ponemos el texto en su variable
        if ( numChildren == 3 ) removeChildAt(2);
        if ( btn.name == "BtnTaoTeKing" ) { 
            texTao.visible = true; 
            activo = texTao; 
            addChild(texTao);
        } 
        if ( btn.name == "BtnWenTzu" ) { 
            texWen.visible = true; 
            activo = texWen;
            addChild(texWen);
        }  
        if ( btn.name == "BtnHuaHuChing" ) { 
            texHua.visible = true ; 
            activo = texHua; 
            addChild(texHua);
        } 
    }
    public function setTextos(txtTao:String,txtWen:String,txtHua:String){
        texTao = miTextField(txtTao);
        texWen = miTextField(txtWen);
        texHua = miTextField(txtHua);
    }
    function miTextField(_txt:String){  // el tipo texto con su formato
        var tex = new TextField();
        tex.name = "texto";
        tex.x = 20;
        tex.y = 10;
        tex.width = 450;
        tex.height = 430;
        tex.multiline = true;
        tex.wordWrap = true;
        var texformat = new TextFormat();
        texformat.color = 0x000000;
        texformat.size = 30;
        texformat.align = JUSTIFY;
        tex.defaultTextFormat = texformat;
        tex.htmlText = _txt;
        tex.visible = false;
        return tex;
    }
}
//---------------------------------------------------------------------------- Clase Btn
// clase de los botones de cada texto.
class Btn extends Sprite {

    var imagen:DisplayObject; // el grafico del boton con el titulo el libro

    public function new(_img:DisplayObject,?_x:Float=0,?_y:Float=0,?_escala:Float=1){
        super();
        imagen = _img;
        x = _x;
        y = _y;
        scaleX = scaleY = _escala;
        alpha = 0;
        addChild(imagen);
        addEventListener(MouseEvent.CLICK, mouseCLICK);
        addEventListener(MouseEvent.ROLL_OVER, mouseOVER);
        addEventListener(MouseEvent.ROLL_OUT, mouseOUT);
    }
    public function mouseCLICK(ev:MouseEvent){
        fondosiguiente();
        var tmp = flash.Lib.current.getChildByName("Menu"); // llamar al menu 
        // para que sepa que se ha picado el boton
        Reflect.callMethod(tmp, Reflect.field(tmp,"botonpicado"),[this]);
    }
    public function mouseOUT(ev:MouseEvent){
        ev.currentTarget.filters = [];
    }
    public function mouseOVER(ev:MouseEvent){
        ev.currentTarget.filters = [new DropShadowFilter(5,20,0x444444)];
    }
    public function difuminado(){ // efecto de difuminado del boton 
        Tweener.addTween(this,{_autoAlpha:1,time:3,transition:"linear"});
    }
    function fondosiguiente(){ // cambiamos el fondo
        var tmp =flash.Lib.current.getChildByName("Fondos");
        Reflect.callMethod(tmp, Reflect.field(tmp,"siguiente"),[]);
    }
}

//------------------------------------------------------------------------------- Clase Btnfull
// el boton que pone el flash en pantalla completa
class BtnFull extends Btn {

    public function new(){
        super(new Fullscr(),740,540);
        name = "BtnFull";
        flash.Lib.current.stage.addEventListener(FullScreenEvent.FULL_SCREEN,fullScreen);
    }
    public override function mouseCLICK(ev:MouseEvent){
        flash.Lib.current.stage.displayState = StageDisplayState.FULL_SCREEN;
        alpha = 0;
        fondosiguiente();
    }
    public function fullScreen(ev:FullScreenEvent){ // si ya esta en pantalla
        // completa no necesitamos que se vea el boton
        if (ev.fullScreen) alpha = 0 else alpha = 1;
    }
    public override function mouseOVER(ev:MouseEvent){
        var glow = new GlowFilter();
        glow.color = 0xffffff;
        glow.alpha = 1;
        glow.blurX = glow.blurY = 2;
        ev.currentTarget.filters = [glow];
    }
    public override function mouseOUT(ev:MouseEvent){
        ev.currentTarget.filters = [];
    }
}

//------------------------------------------------------------------------------- Clase Menu
// para manejar todo el menu, coordinar los botones y la ventana de los textos.
class Menu extends Sprite {

    var taoteking:Btn;   // todos los botones
    var huahuching:Btn;
    var wentzu:Btn;
    var fullscr:BtnFull;
    var presentado:Bool; // si ya se presentaron los botones al inicio
    var ventana:Ventana; // la ventana de los textos

    public function new(){
        super();
        presentado = false;
        name = "Menu";
        ventana = cast(flash.Lib.current.getChildByName("Ventana"),Ventana);
        // pondremos los textos en la ventana
        ventana.setTextos(haxe.Resource.getString("texto_taoteking"),
                haxe.Resource.getString("texto_wentzu"),
                haxe.Resource.getString("texto_huahuching"));
        // construimos los botones
        taoteking = new Btn(new TaoTeKing(),200,100);
        taoteking.name = "BtnTaoTeKing";
        this.addChild(taoteking);
        huahuching = new Btn(new HuaHuChing(),200,300);
        huahuching.name = "BtnHuaHuChing";
        this.addChild(huahuching);
        wentzu = new Btn(new WenTzu(),200,200);
        wentzu.name = "BtnWenTzu";
        this.addChild(wentzu);
        fullscr = new BtnFull();
        this.addChild(fullscr);
    }
    public function inicio(){ // efectos iniciales del menu y el simbolo del tao
        taoteking.difuminado();
        huahuching.difuminado();
        wentzu.difuminado();
        fullscr.difuminado();
        var chino = flash.Lib.current.getChildByName("Chino"); // simbolo del tao
        Tweener.addTween(chino,{_color:0xffffff,time:3,transition:"linear"});
    }
    function nuevoTexto(btn:Btn){ // nuevo texto en la ventana: el del boton
        // picado, y hacemos visible el texto de cargando...
        var men = cast(flash.Lib.current.getChildByName("Mensajes"),TextField);
        men.visible = true;
        ventana.setTexto(btn);
    }
    function cargado(){ // quitar el texto cargando... porque ya está cargado
        var men = cast(flash.Lib.current.getChildByName("Mensajes"),TextField);
        men.visible = false;
    }
    public function botonpicado(btn:Btn){ // efectos del menu
        if ( presentado ){ // efectos de la ventana cuando se pica un boton
            Tweener.addTween(ventana,{x:10,y:10,height:10,width:10,_autoAlpha:0,time:2,transition:"linear",onComplete:nuevoTexto,onCompleteParams:[btn]});
            Tweener.addTween(ventana,{x:250,y:50,height:460,width:500,_autoAlpha:0.5,time:2,delay:3,transition:"linear",onComplete:cargado});
        }
        else { // efectos del menu cuando se pica un boton la primera vez
            presentado = true;
            nuevoTexto(btn);
            Tweener.addTween(taoteking,{x:10,y:50,_scale:0.5,_color:0xffffff,time:1.5,transition:"linear"});
            Tweener.addTween(wentzu,{x:10,y:100,_scale:0.5,_color:0xffffff,time:1.5,delay:0.5,transition:"linear"});
            Tweener.addTween(huahuching,{x:10,y:150,_scale:0.5,_color:0xffffff,time:1.5,delay:1,transition:"linear"});
            Tweener.addTween(ventana,{x:250,y:50,height:460,width:500,_autoAlpha:0.5,time:3,delay:1.5,transition:"linear",onComplete:cargado});
        }
    }
}

//----------------------------------------------------------------------- Clase Fondos
// para controlar las imagenes del fondo
class Fondos extends Sprite {
    var fotos:Array<String>;    
    var foto:Loader;
    var url:URLRequest;
    var imsLdr:URLLoader;
    var mc:MovieClip;
    var tmpIndice:Int;
    var contador:Int;
    var auto:Bool;
    var indice:Int;

    public function new(){
        super();
        mc = flash.Lib.current;
        name = "Fondos";
        // cargamos la lista de las imagenes del archivo imagenes.txt
        var imsReq:URLRequest = new URLRequest("recursos/imagenes.txt");
        imsLdr  = new URLLoader();
        imsLdr.dataFormat = URLLoaderDataFormat.VARIABLES;
        imsLdr.addEventListener(Event.COMPLETE, preparar);
        imsLdr.load(imsReq);
        indice = 0;
        tmpIndice = 0;
        auto = false;
        contador = 0;
        this.addEventListener(Event.ENTER_FRAME,cargar);
    }
    function preparar(event:Event) {
        fotos = imsLdr.data.imagenes.split("-x-");
    }
    public function fondo(?_indice:Int=0){
        indice = _indice;
    }
    public function siguiente(){ // incrementamos el indice que indica el fondo
        // a cargar
        if ( indice == 11 ) indice = 0 else indice++;
    }
    public function automatico(val:Bool){ // si se cambia el fondo
        // automaticamente o no
        auto = val;
    }
    function cargar(ev:Event){ // si cambia el indice se carga la foto
        if (indice != tmpIndice){
            foto = new Loader();
            url = new URLRequest("recursos/" + fotos[indice]);
            foto.load(url);
            foto.contentLoaderInfo.addEventListener(Event.COMPLETE, leido);
            tmpIndice = indice;
        }
        if ( auto && contador >= 200 ) { // contador para el modo automatico
            siguiente(); 
            contador = 0;
        } else contador++;
    }
    function leido(ev:Event) { //borra la imagen anterior y carga la nueva con
        // difuminado
        if ( numChildren > 1 ) removeChildAt(0);
        foto.alpha = 0;
        Tweener.addTween(foto,{_autoAlpha:1,time:2,transition:"linear"});
        addChild(foto);
    }
}

//----------------------------------------------------------------------- Clase Tao
// clase de inicio del programa
class Tao {

    public static inline var mc = flash.Lib.current; 
    static var contador:Int; // para el movimiento del mensaje Cargando...

    public static function main(){

        mc.stage.scaleMode = StageScaleMode.EXACT_FIT; // ajuste de la pelicula
        // al stage
        contador = 0;
        // cargamos el primer fondo
        var niebla = new Niebla();
        niebla.name = "Niebla";
        mc.addChild(niebla);
        // iniciamos los fondos en modo automatico
        var miFondo = new Fondos();
        miFondo.automatico(true);
        mc.addChild(miFondo);
        // construimos la ventana
        var ventana = new Ventana();
        mc.addChild(ventana);
        // construimos la ventana
        var menu = new Menu();
        mc.addChild(menu);
        // ponemos el simbolo del tao
        var chino = new Chino();
        chino.name = "Chino";
        mc.addChild(chino);
        chino.x = 250; chino.y = 200;
        // el texto Cargando...
        var mensajes = new TextField();
        mensajes.x = 350;
        mensajes.y = 300;
        mensajes.textColor = 0xffffff;
        mensajes.name = "Mensajes";
        mensajes.htmlText = "";
        mensajes.visible = false;
        mensajes.autoSize = TextFieldAutoSize.RIGHT;
        mc.addChild(mensajes);
        mc.addEventListener(Event.ENTER_FRAME,cargando);
        // iniciamos los efectos
        DisplayShortcuts.init();
        ColorShortcuts.init();
        // efectos iniciales
        Tweener.addTween(chino,{_scale:0.5,x:300,y:250,time:1,transition:"linear"});
        Tweener.addTween(chino,{y:445,x:10,time:2,transition:"linear",delay:1,onComplete:menu.inicio});
    }
    static function cargando(ev:Event) { // mensaje Cargando ...
        var men = cast(flash.Lib.current.getChildByName("Mensajes"),TextField);
        if ( contador <= 1 ){
            men.htmlText = '<b><font size="30">Cargando .  </font></b>';
            contador++;
        }
        if ( contador >= 2 && contador <= 3 ){
            men.htmlText = '<b><font size="30">Cargando .. </font></b>';
            contador++;
        }
        if ( contador >= 4 && contador <= 5 ){
            men.htmlText = '<b><font size="30">Cargando ...</font></b>';
            contador++;
        }
        if ( contador >= 6 ){
            contador = 0;
        }
    }
}
