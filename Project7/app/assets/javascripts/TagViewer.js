function TagViewer(photoID, tags) {
	var obj = this;
	this.photo = document.getElementById(photoID);
	console.log(tags);
	for(var i=0; i<tags.length; i++) {
		console.log(i);
	}
}

/*
<% for tag in photo.tags do %>
						<% puts "tag.x_pos" %>
						<div class="tag" style="left:" + <%=tag.x_pos%> + "; top:<%=tag.y_pos%>; width:<%=tag.width%>px; height:<%=tag.height%>px; "></div>
					<% end %>
*/