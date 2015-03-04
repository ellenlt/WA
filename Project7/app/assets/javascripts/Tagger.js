//Tagger constructor
function Tagger(photoID, tagID) {
    this.isMouseDown = false;
    var obj = this;
	this.photo = document.getElementById(photoID);
	this.tag = document.getElementById(tagID);
    //Changes positioning context so that tag coordinates are relative to photo
    this.photo.style.position = "relative";
    this.tag.style.position = "absolute";
    this.photo.addEventListener("mousedown", obj.mouseDown.bind(obj));
    this.oldMoveHandler = document.body.onmousemove;
    this.photo.addEventListener("mousemove", obj.mouseMove.bind(obj));    
    this.oldUpHandler = document.body.onmouseup;
    this.photo.addEventListener("mouseup", obj.mouseUp.bind(obj));
}

//On mouseDown, sets coordinates of corner of tag
Tagger.prototype.mouseDown = function(evt) {
//	console.log("offset: " + this.photo.offsetLeft + ", " + this.photo.offsetTop);
//    console.log("client: " + evt.clientX + ", " + evt.clientY);
 //   console.log("page: " + evt.pageX + ", " + evt.pageY);
    this.x1 = evt.clientX;
    this.y1 = evt.clientY;
    this.isMouseDown = true;
    evt.preventDefault();
    this.tag.style.visibility = "visible";
}

Tagger.prototype.mouseMove = function(evt) {
    if (!this.isMouseDown) {
        return;
    }
    var x2 = evt.clientX;
    var y2 = evt.clientY;

    var tagWidth = Math.abs(x2 - this.x1);
    var tagHeight = Math.abs(y2 - this.y1);

    var tagX;
    var tagY;

    if(this.x1 < x2) {	//Dragging tag to the right
    	tagX = Tagger.getOffsetLeft(this.x1, this.photo);
    	//If right edge of tag goes past right edge of photo
    	if(tagX + tagWidth > this.photo.offsetWidth) {
    		tagWidth = this.photo.offsetWidth - tagX;
    	}
    } else if (this.x1 > x2) {		//Dragging tag to the left
    	tagX = Tagger.getOffsetLeft(x2, this.photo);
    	//If left edge of tag goes past left edge of photo
    	if(tagX < 0) {
    		tagWidth = Tagger.getOffsetLeft(this.x1, this.photo);
    		tagX = 0;
    	}
    }
    if(this.y1 < y2) {	//Dragging tag down
    	tagY = Tagger.getOffsetTop(this.y1, this.photo);
    	//If bottom edge of tag goes past bottom of photo
    	if(tagY + tagHeight > this.photo.offsetHeight) {
    		tagHeight = this.photo.offsetHeight - tagY;
    	}
    } else if (this.y1 > y2) {	//Dragging tag up
    	tagY = Tagger.getOffsetTop(y2, this.photo);
    	//If top edge of tag goes past top of photo
    	if(tagY < 0) {
    		tagHeight = Tagger.getOffsetTop(this.y1, this.photo);
    		tagY = 0;
    	}
    }
    this.tag.style.width = tagWidth + "px";
	this.tag.style.height = tagHeight + "px";
	this.tag.style.left = tagX + "px";
    this.tag.style.top = tagY + "px";
    evt.preventDefault();
}

Tagger.prototype.mouseUp = function(evt) {
    this.isMouseDown = false;
    document.body.onmousemove = this.oldMoveHandler;
    document.body.onmouseup = this.oldUpHandler;
    evt.preventDefault();
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
 //   console.log("initial offsetTop: " + offsetTop);
    while (elem.nodeName != "BODY") {
    	if(!isNaN(elem.offsetTop)) {
        	offsetTop -= elem.offsetTop;
      	}
   //   	console.log("curr elem: " + elem.id);
     // 	console.log("curr offset: " + offsetTop);
      	elem = elem.parentNode;
    }
  //  console.log("final offsetTop: " + offsetTop);
    return offsetTop;
}