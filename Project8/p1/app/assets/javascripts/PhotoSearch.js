function ajaxSearch(controllerName, methodName, searchField, resultsField) {
		var obj = this;
		this.searchField = document.getElementById(searchField);
		this.searchField.addEventListener("input", function(evt) {obj.onInput(evt)})
		this.resultsField = document.getElementById(resultsField);
		this.url = "/" + controllerName + "/" + methodName + "?" + searchField + "="
}

ajaxSearch.prototype.onInput = function(evt) {
	var ajaxSearchObj = this;
	var substring = this.searchField.value;
	xhr = new XMLHttpRequest();

	xhr.open("GET", this.url + encodeURIComponent(substring));
	xhr.send();

	xhr.onreadystatechange = function() {
		if (this.readyState != 4) {
			return;
		}
		if (this.status != 200) {
			return;
		}
		ajaxSearchObj.resultsField.innerHTML = this.responseText;
	}
	// Return false to prevent the form from actually submitting and reloading the page
	return false;
}