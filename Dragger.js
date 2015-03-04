function Dragger(id, id2) {
    this.isMouseDown = false;
    var obj = this;
    this.element = document.getElementById(id);
    this.tag = document.getElementById(id2);

    this.element.style.position = "relative";
    this.tag.style.position = "absolute";
    this.element.addEventListener("mousedown", obj.mouseDown.bind(obj));
    this.oldMoveHandler = document.body.onmousemove;
    this.element.addEventListener("mousemove", obj.mouseMove.bind(obj));    
    this.oldUpHandler = document.body.onmouseup;
    this.element.addEventListener("mouseup", obj.mouseUp.bind(obj));
}

//this refers to dragger object, this.element refers to div
//this refers to div
Dragger.prototype.mouseDown = function(evt) {
    console.log("client: " + evt.clientX + ", " + evt.clientY);
    console.log("page: " + evt.pageX + ", " + evt.pageY);
    this.x1 = evt.clientX;
    this.y1 = evt.clientY;
    this.isMouseDown = true;
    evt.preventDefault();
         console.log("offset: " + this.element.offsetLeft + ", " + this.element.offsetTop);
}

Dragger.prototype.mouseMove = function(evt) {
    if (!this.isMouseDown) {
        return;
    }
    var x2 = evt.clientX;
    var y2 = evt.clientY;
    //Point 1 is top left corner
    if(this.x1 < x2 && this.y1 < y2) {
        this.tag.style.left = this.x1 - this.element.offsetLeft + "px";
        this.tag.style.top = this.y1 - this.element.offsetTop + "px";
        this.tag.style.width = (x2 - this.x1) + "px";
        this.tag.style.height = (y2 - this.y1) + "px";
    }
     evt.preventDefault();
}

Dragger.prototype.mouseUp = function(evt) {
    this.isMouseDown = false;
    document.body.onmousemove = this.oldMoveHandler;
    document.body.onmouseup = this.oldUpHandler;
     evt.preventDefault();
}