//Tagger constructor
function Tagger(photoID, tagID, x, y, width, height) {
    this.isMouseDown = false;
    var obj = this;
	this.photo = document.getElementById(photoID);
	this.tag = document.getElementById(tagID);
	this.xForm = document.getElementById(x);
	this.yForm = document.getElementById(y);
	this.widthForm = document.getElementById(width);
	this.heightForm = document.getElementById(height);
  	//Changes positioning context so that tag coordinates are relative to photo
    this.photo.style.position = "relative";
    this.tag.style.position = "absolute";
    this.photo.addEventListener("mousedown", function(evt) {obj.mouseDown(evt)});
    this.oldMoveHandler = document.body.onmousemove;
    this.photo.addEventListener("mousemove", function(evt) {obj.mouseMove(evt)});    
    this.oldUpHandler = document.body.onmouseup;
    this.photo.addEventListener("mouseup", function(evt) {obj.mouseUp(evt)});
}

//On mouseDown, sets coordinates of corner of tag
Tagger.prototype.mouseDown = function(evt) {
    this.mouseX1 = evt.clientX;
    this.mouseY1 = evt.clientY;
    this.isMouseDown = true;
    evt.preventDefault();
    this.tag.style.visibility = "visible";
}

Tagger.prototype.mouseMove = function(evt) {
    if (!this.isMouseDown) {
        return;
    }
    var mouseX2 = evt.clientX;
    var mouseY2 = evt.clientY;
    //Tag width and height
    this.tagWidth = Math.abs(mouseX2 - this.mouseX1);
    this.tagHeight = Math.abs(mouseY2 - this.mouseY1);
    //Top left coordinates of tag
    this.tagX;
    this.tagY;
    if(this.mouseX1 < mouseX2) {	//Dragging tag to the right
    	this.tagX = Tagger.getOffsetLeft(this.mouseX1, this.photo);
    	//If right edge of tag goes past right edge of photo
    	if(this.tagX + this.tagWidth > this.photo.offsetWidth) {
    		this.tagWidth = this.photo.offsetWidth - this.tagX;
    	}
    } else if (this.mouseX1 > mouseX2) {		//Dragging tag to the left
    	this.tagX = Tagger.getOffsetLeft(mouseX2, this.photo);
    	//If left edge of tag goes past left edge of photo
    	if(this.tagX < 0) {
    		this.tagWidth = Tagger.getOffsetLeft(this.mouseX1, this.photo);
    		this.tagX = 0;
    	}
    }
    if(this.mouseY1 < mouseY2) {	//Dragging tag down
    	this.tagY = Tagger.getOffsetTop(this.mouseY1, this.photo);
    	//If bottom edge of tag goes past bottom of photo
    	if(this.tagY + this.tagHeight > this.photo.offsetHeight) {
    		this.tagHeight = this.photo.offsetHeight - this.tagY;
    	}
    } else if (this.mouseY1 > mouseY2) {	//Dragging tag up
    	this.tagY = Tagger.getOffsetTop(mouseY2, this.photo);
    	//If top edge of tag goes past top of photo
    	if(this.tagY < 0) {
    		this.tagHeight = Tagger.getOffsetTop(this.mouseY1, this.photo);
    		this.tagY = 0;
    	}
    }
    this.tag.style.width = this.tagWidth + "px";
	this.tag.style.height = this.tagHeight + "px";
	this.tag.style.left = this.tagX + "px";
    this.tag.style.top = this.tagY + "px";
    evt.preventDefault();
}

Tagger.prototype.mouseUp = function(evt) {
	evt.preventDefault();
    this.isMouseDown = false;
    document.body.onmousemove = this.oldMoveHandler;
    document.body.onmouseup = this.oldUpHandler;
    userMenu = document.getElementById("user_menu");
    userMenu.style.visibility = "visible";
    userMenu.style.position = "absolute";
    userMenu.style.left = this.tagX + "px";
    userMenu.style.top = this.tagY + this.tagHeight + "px";
    this.xForm.value = this.tagX;
	this.yForm.value = this.tagY;
	this.widthForm.value = this.tagWidth;
	this.heightForm.value = this.tagHeight;
}

//Returns x-coordinate of tag relative to photo
Tagger.getOffsetLeft = function(mouseX, elem) {
    var offsetLeft = mouseX + document.body.scrollLeft;
    while (elem.nodeName != "BODY") {
    	if(!isNaN(elem.offsetLeft)) {
        	offsetLeft -= elem.offsetLeft;
      	}
      	elem = elem.parentNode;
    }
    return offsetLeft;
}

//Returns y-coordinate of tag relative to photo
Tagger.getOffsetTop = function(mouseY, elem) {
    var offsetTop = mouseY + document.body.scrollTop;
    while (elem.nodeName != "BODY") {
    	if(!isNaN(elem.offsetTop)) {
        	offsetTop -= elem.offsetTop;
      	}
      	elem = elem.parentNode;
    }
    return offsetTop;
}