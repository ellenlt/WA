//Calendar constructor
function Calendar(divId) {
	this.elem = document.getElementById(divId);
	this.elem.className = "cal";
	this.id = divId;
}

//Render method for Calendar objects
Calendar.prototype.render = function(today) {
	var calendar = this;
	this.elem.innerHTML = "";		//Clear existing div contents

	//Header containing month name, year, and buttons to go to previous and next months
	this.elem.innerHTML =
		"<div class='header'>" +
		  "<a href class='prev' id='" + this.id + "prev' >&lt&lt</a>" +
		  "<span class='title'>" + Calendar.monthNames[today.getMonth()] + " " + today.getFullYear() + "</span>" +
		  "<a href class='next' id='" + this.id + "next'>&gt&gt</a>" +
		"</div>" +
		"<table class='body' id='" + this.id + "body'><tr><td class='label'>Su</td><td class='label'>M</td><td class='label'>Tu</td><td class='label'>W</td><td class='label'>Th</td><td class='label'>F</td><td class='label'>Sa</td></tr></table>";
		
	var currDay = Calendar.calcStartDate(today);
	var lastDay = Calendar.calcEndDate(today);
	
	//Creates calendar body
	while (currDay < lastDay) {
		var wk = document.createElement("TR");
		(document.getElementById(this.id + 'body')).appendChild(wk);
		for (var i=0; i<7; i++) {
			var cell = document.createElement("TD");
			cell.className="cell";
			//Highlights today
			if (currDay.getTime() == today.getTime()) {
				cell.className="highlighted_cell";
			} else if (currDay.getMonth() != today.getMonth()) {
			//Grays out days not in active month
				cell.className="inactive_cell";
			}
			cell.innerHTML = currDay.getDate();
			wk.appendChild(cell);
			currDay.setDate(currDay.getDate()+1);
		}
	}

	//Binds events to previous and next buttons
	(document.getElementById(this.id + 'prev')).onclick = function(event) {
		calendar.render(Calendar.prevMonth(today));
		event.preventDefault();
	};
	(document.getElementById(this.id + 'next')).onclick = function (event) {
		calendar.render(Calendar.nextMonth(today));
		event.preventDefault();
	};
};

//Calculates the first day to display on the calendar body
Calendar.calcStartDate = function(d) {
	var result = new Date(d);
	result.setDate(1);
	//If the first day of the month is not a Sunday,
	//finds closest preceding Sunday to begin calendar with
	if(result.getDay != 0) {
		result.setDate(1-d.getDay())
	}
	return result;
};

//Calculates the last day to display on the calendar body
Calendar.calcEndDate = function(d) {
	var result = new Date(d);
	result.setMonth(result.getMonth() + 1);
	result.setDate(0);
	//If the last day of the month is not a Saturday,
	//finds closest following Saturday to end calendar with
	if(result.getDay() != 6) {
		var add = result.getDate() + (6 - result.getDay());
		result.setDate(add);
	}
	return result;
};

//Renders previous month from date d
Calendar.prevMonth = function(d) {
	var result = new Date(d);
	result.setMonth(result.getMonth() - 1);
	result.setDate(1);
	return result;
};

//Renders next month from date d
Calendar.nextMonth = function(d) {
	var result = new Date(d);
	result.setMonth(result.getMonth() + 1);
	result.setDate(1);
	return result;
};

//Correlates month numbers to names
Calendar.monthNames = [ "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December" ];