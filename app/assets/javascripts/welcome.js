$(function(){
		var container = document.getElementById('container');
		var list = document.getElementById('list');
		var buttons = document.getElementById('buttons').getElementsByTagName('span');
        var prev = document.getElementById('prev');
        var next = document.getElementById('next');
        var index = 1;
        var animated = false;
        var timer;

        function animate(offset){
        	animated = true;
        	var newLeft = parseInt(list.style.left) + offset;
        	// var time = 300;
        	var inteval = 10;
        	var speed = offset/inteval;
        	var go = function(){
            			if((speed > 0 && parseInt(list.style.left) < newLeft) || (speed < 0 && parseInt(list.style.left) > newLeft)){
            				list.style.left = parseInt(list.style.left) + speed + 'px';
            				setTimeout(go, 30);
            			}else{
            				if(newLeft > -850){
                                list.style.left = -4250 + 'px';
                            }
                            if(newLeft < -4250) {
                                list.style.left = -850 + 'px';
                            }
                            animated = false;
            			}
        	       }
        	go();
        }

        function play(){
        	timer = setInterval(function(){
        		next.onclick();
        	}, 3000)
        }

        function stop(){
        	clearInterval(timer);
        }

        function showButton(){
        	for (var i = 0; i < buttons.length; i++) {
        		if (buttons[i].className == 'on') {
        			buttons[i].className = '';
        			break;
        		};
        	};
        	buttons[index - 1].className = 'on';
        }

        next.onclick = function(){
        	if (animated) {
            return;
          }

        	if (index == 5) {
        		index = 1
        	}else{
        		index += 1;		
        	};
        	animate(-850);
        	showButton();
        }

        prev.onclick = function(){
        	if (animated) {
            return;
          }

        	if (index == 1) {
        		index = 5
        	}else{
        		index -= 1;		
        	};
        	animate(850);
        	showButton();
        }

       	for (var i = 0; i < buttons.length; i++) {
       		buttons[i].onclick = function(){
       			if (this.className == 'on') {
       				return;
       			};
       			var myIndex = parseInt(this.getAttribute('index'));
       			var offset = -850 * (myIndex - index);
       			animate(offset);
       			index = myIndex;
       			showButton();
       		}
       	};

       	container.onmouseover = stop;
        container.onmouseout = play;
    		play();

    });