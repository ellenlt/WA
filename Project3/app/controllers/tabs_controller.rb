class TabsController < ApplicationController
  def show2
  	@tabs_v1 = [{:label=>"Inventory", :url=>"inventories"},
  				{:label=>"Order Information", :url=>"orders"},
  				{:label=>"Accounts", :url=>"accounts"},
  				{:label=>"Shippers", :url=>"shippers"},
  				{:label=>"Suppliers", :url=>"suppliers"}];
  	@active_tab1 = "Accounts";

  	@tabs_v2 = [{:label=>"Bio", :url=>"bio"},
  				{:label=>"Projects", :url=>"projects"},
  				{:label=>"Writings", :url=>"writings"},
  				{:label=>"Photos", :url=>"photos"},
  				{:label=>"Press", :url=>"press"}];
  	@active_tab2 = "Projects";
  end
end