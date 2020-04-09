window.jQuery = window.$ = jQuery;

/* Custom Scripts */



/*-----------------------------------------------------------------------------------*/
/*	CHART
/*-----------------------------------------------------------------------------------*/
jQuery(document).ready(function(){
    var chart = $('.chart'),
        chartNr = $('.chart-content'),
        chartParent = chart.parent();

    function centerChartsNr() {
        chartNr.css({
            top: (chart.height() - chartNr.outerHeight()) / 2
        });
    }

    if (chart.length) {
        centerChartsNr();
        $(window).resize(centerChartsNr);

        chartParent.each(function () {
            $(this).onScreen({
                doIn: function () {
                    $(this).find('.chart').easyPieChart({
                       animate: 1000,
					  lineWidth: 3,
					  barColor:'#2f2f2f',
					  trackColor:'#dcdcdc',
					  lineCap:false,
					  lineWidth:'2',
					  size:'72',
					  scaleColor:false,
						
						scaleColor:false,
                        animate: 2000,
                        onStep: function (from, to, percent) {
                            $(this.el).find('.percent').text(Math.round(percent));
                        }
                    });
                },
            });
        });
    }
});

/**!
 * easyPieChart
 * Lightweight plugin to render simple, animated and retina optimized pie charts
 *
 * @license Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 * @author Robert Fleischmann <rendro87@gmail.com> (http://robert-fleischmann.de)
 * @version 2.1.3
 **/
!function(a,b){"object"==typeof exports?module.exports=b(require("jquery")):"function"==typeof define&&define.amd?define("EasyPieChart",["jquery"],b):b(a.jQuery)}(this,function(a){var b=function(a,b){var c,d=document.createElement("canvas");"undefined"!=typeof G_vmlCanvasManager&&G_vmlCanvasManager.initElement(d);var e=d.getContext("2d");d.width=d.height=b.size,a.appendChild(d);var f=1;window.devicePixelRatio>1&&(f=window.devicePixelRatio,d.style.width=d.style.height=[b.size,"px"].join(""),d.width=d.height=b.size*f,e.scale(f,f)),e.translate(b.size/2,b.size/2),e.rotate((-0.5+b.rotate/180)*Math.PI);var g=(b.size-b.lineWidth)/2;b.scaleColor&&b.scaleLength&&(g-=b.scaleLength+2),Date.now=Date.now||function(){return+new Date};var h=function(a,b,c){c=Math.min(Math.max(-1,c||0),1);var d=0>=c?!0:!1;e.beginPath(),e.arc(0,0,g,0,2*Math.PI*c,d),e.strokeStyle=a,e.lineWidth=b,e.stroke()},i=function(){var a,c,d=24;e.lineWidth=1,e.fillStyle=b.scaleColor,e.save();for(var d=24;d>0;--d)0===d%6?(c=b.scaleLength,a=0):(c=.6*b.scaleLength,a=b.scaleLength-c),e.fillRect(-b.size/2+a,0,c,1),e.rotate(Math.PI/12);e.restore()},j=function(){return window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||function(a){window.setTimeout(a,1e3/60)}}(),k=function(){b.scaleColor&&i(),b.trackColor&&h(b.trackColor,b.lineWidth,1)};this.clear=function(){e.clearRect(b.size/-2,b.size/-2,b.size,b.size)},this.draw=function(a){b.scaleColor||b.trackColor?e.getImageData&&e.putImageData?c?e.putImageData(c,0,0):(k(),c=e.getImageData(0,0,b.size*f,b.size*f)):(this.clear(),k()):this.clear(),e.lineCap=b.lineCap;var d;d="function"==typeof b.barColor?b.barColor(a):b.barColor,h(d,b.lineWidth,a/100)}.bind(this),this.animate=function(a,c){var d=Date.now();b.onStart(a,c);var e=function(){var f=Math.min(Date.now()-d,b.animate),g=b.easing(this,f,a,c-a,b.animate);this.draw(g),b.onStep(a,c,g),f>=b.animate?b.onStop(a,c):j(e)}.bind(this);j(e)}.bind(this)},c=function(a,c){var d={barColor:"#ef1e25",trackColor:"#f9f9f9",scaleColor:"#dfe0e0",scaleLength:5,lineCap:"round",lineWidth:3,size:110,rotate:0,animate:1e3,easing:function(a,b,c,d,e){return b/=e/2,1>b?d/2*b*b+c:-d/2*(--b*(b-2)-1)+c},onStart:function(){},onStep:function(){},onStop:function(){}};if("undefined"!=typeof b)d.renderer=b;else{if("undefined"==typeof SVGRenderer)throw new Error("Please load either the SVG- or the CanvasRenderer");d.renderer=SVGRenderer}var e={},f=0,g=function(){this.el=a,this.options=e;for(var b in d)d.hasOwnProperty(b)&&(e[b]=c&&"undefined"!=typeof c[b]?c[b]:d[b],"function"==typeof e[b]&&(e[b]=e[b].bind(this)));e.easing="string"==typeof e.easing&&"undefined"!=typeof jQuery&&jQuery.isFunction(jQuery.easing[e.easing])?jQuery.easing[e.easing]:d.easing,this.renderer=new e.renderer(a,e),this.renderer.draw(f),a.dataset&&a.dataset.percent?this.update(parseFloat(a.dataset.percent)):a.getAttribute&&a.getAttribute("data-percent")&&this.update(parseFloat(a.getAttribute("data-percent")))}.bind(this);this.update=function(a){return a=parseFloat(a),e.animate?this.renderer.animate(f,a):this.renderer.draw(a),f=a,this}.bind(this),g()};a.fn.easyPieChart=function(b){return this.each(function(){var d;a.data(this,"easyPieChart")||(d=a.extend({},b,a(this).data()),a.data(this,"easyPieChart",new c(this,d)))})}});
(function(e){e.fn.onScreen=function(t){var n=e.extend({container:window,direction:"vertical",toggleClass:null,doIn:null,doOut:null,tolerance:0,throttle:null,lazyAttr:null,lazyPlaceholder:"data:image/gif;base64,R0lGODlhEAAFAIAAAP///////yH/C05FVFNDQVBFMi4wAwEAAAAh+QQJCQAAACwAAAAAEAAFAAACCIyPqcvtD00BACH5BAkJAAIALAAAAAAQAAUAgfT29Pz6/P///wAAAAIQTGCiywKPmjxUNhjtMlWrAgAh+QQJCQAFACwAAAAAEAAFAIK8urzc2tzEwsS8vrzc3tz///8AAAAAAAADFEiyUf6wCEBHvLPemIHdTzCMDegkACH5BAkJAAYALAAAAAAQAAUAgoSChLS2tIyKjLy+vIyOjMTCxP///wAAAAMUWCQ09jAaAiqQmFosdeXRUAkBCCUAIfkECQkACAAsAAAAABAABQCDvLq83N7c3Nrc9Pb0xMLE/P78vL68/Pr8////AAAAAAAAAAAAAAAAAAAAAAAAAAAABCEwkCnKGbegvQn4RjGMx8F1HxBi5Il4oEiap2DcVYlpZwQAIfkECQkACAAsAAAAABAABQCDvLq85OLkxMLE9Pb0vL685ObkxMbE/Pr8////AAAAAAAAAAAAAAAAAAAAAAAAAAAABCDwnCGHEcIMxPn4VAGMQNBx0zQEZHkiYNiap5RaBKG9EQAh+QQJCQAJACwAAAAAEAAFAIOEgoTMysyMjozs6uyUlpSMiozMzsyUkpTs7uz///8AAAAAAAAAAAAAAAAAAAAAAAAEGTBJiYgoBM09DfhAwHEeKI4dGKLTIHzCwEUAIfkECQkACAAsAAAAABAABQCDvLq85OLkxMLE9Pb0vL685ObkxMbE/Pr8////AAAAAAAAAAAAAAAAAAAAAAAAAAAABCAQSTmMEGaco8+UBSACwWBqHxKOJYd+q1iaXFoRRMbtEQAh+QQJCQAIACwAAAAAEAAFAIO8urzc3tzc2tz09vTEwsT8/vy8vrz8+vz///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAEIhBJWc6wJZAtJh3gcRBAaXiIZV2kiRbgNZbA6VXiUAhGL0QAIfkECQkABgAsAAAAABAABQCChIKEtLa0jIqMvL68jI6MxMLE////AAAAAxRoumxFgoxGCbiANos145e3DJcQJAAh+QQJCQAFACwAAAAAEAAFAIK8urzc2tzEwsS8vrzc3tz///8AAAAAAAADFFi6XCQwtCmAHbPVm9kGWKcEQxkkACH5BAkJAAIALAAAAAAQAAUAgfT29Pz6/P///wAAAAIRlI8SAZsPYnuJMUCRnNksWwAAOw==",debug:false},t);return this.each(function(){function m(){if(v){return p<f-n.tolerance&&r<p+c-n.tolerance}else{return p<u-n.tolerance&&p>-c+n.tolerance}}function g(){if(v){return p+(c-n.tolerance)<r||p>f-n.tolerance}else{return p>u-n.tolerance||-c+n.tolerance>p}}function y(){if(v){return d<l-n.tolerance&&i<d+h-n.tolerance}else{return d<a-n.tolerance&&d>-h+n.tolerance}}function b(){if(v){return d+(h-n.tolerance)<i||d>l-n.tolerance}else{return d>a-n.tolerance||-h+n.tolerance>d}}function w(){if(t){return false}if(n.direction==="horizontal"){return y()}else{return m()}}function E(){if(!t){return false}if(n.direction==="horizontal"){return b()}else{return g()}}function S(e,t,n){var r,i,s;return function(){i=arguments;s=true;n=n||this;if(!r){(function(){if(s){e.apply(n,i);s=false;r=setTimeout(arguments.callee,t)}else{r=null}})()}}}var t=false;var r;var i;var s=e(this);var o;var u;var a;var f;var l;var c;var h;var p;var d;var v=e.isWindow(n.container);var x=function(){if(!v&&e(n.container).css("position")==="static"){e(n.container).css("position","relative")}o=e(n.container);u=o.height();a=o.width();f=o.scrollTop()+u;l=o.scrollLeft()+a;c=s.outerHeight(true);h=s.outerWidth(true);if(v){var m=s.offset();p=m.top;d=m.left}else{var g=s.position();p=g.top;d=g.left}r=o.scrollTop();i=o.scrollLeft();if(n.debug){console.log("Container: "+n.container+"\n"+"Width: "+u+"\n"+"Height: "+a+"\n"+"Bottom: "+f+"\n"+"Right: "+l);console.log("Matched element: "+(s.attr("class")!==undefined?s.prop("tagName").toLowerCase()+"."+s.attr("class"):s.prop("tagName").toLowerCase())+"\n"+"Left: "+d+"\n"+"Top: "+p+"\n"+"Width: "+h+"\n"+"Height: "+c)}if(w()){if(n.toggleClass){s.addClass(n.toggleClass)}if(e.isFunction(n.doIn)){n.doIn.call(s[0])}if(n.lazyAttr&&s.prop("tagName")==="IMG"){var y=s.attr(n.lazyAttr);s.css({background:"url("+n.lazyPlaceholder+") 50% 50% no-repeat",minHeight:"5px",minWidth:"16px"});s.prop("src",y)}t=true}else if(E()){if(n.toggleClass){s.removeClass(n.toggleClass)}if(e.isFunction(n.doOut)){n.doOut.call(s[0])}t=false}};if(window.location.hash){S(x,50)}else{x()}if(n.throttle){x=S(x,n.throttle)}e(n.container).on("scroll resize",x);if(typeof module==="object"&&module&&typeof module.exports==="object"){module.exports=jQuery}else{if(typeof define==="function"&&define.amd){define("jquery-onscreen",[],function(){return jQuery})}}})}})(jQuery);

/**/


