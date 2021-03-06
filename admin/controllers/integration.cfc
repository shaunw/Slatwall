/*

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

*/
component extends="BaseController" output=false accessors=true {

	property name="integrationService";

	public void function default(required struct rc) {
		getFW().redirect(action="admin:integration.list");
	}
	
	public void function list(required struct rc) {
		rc.integrationSmartList = getIntegrationService().getIntegrationSmartList(rc);
		rc.integrationSmartList.addOrder("integrationName|ASC");
	}
	
	public void function detail(required struct rc) {
		param name="rc.integrationPackage" default="";
		param name="rc.edit" default="false";
		
		rc.integration = getIntegrationService().getIntegrationByIntegrationPackage(rc.integrationPackage);
		rc.itemTitle &= ": " & rc.integration.getIntegrationName();
	}

	public void function edit(required struct rc) {
		detail(arguments.rc);
		getFW().setView("admin:integration.detail");
		rc.edit = true;
	}

	public void function save(required struct rc) {
		detail(arguments.rc);
		
		rc.integration = getIntegrationService().saveIntegration(rc.integration, rc);
	   
		if(!rc.integration.hasErrors()) {
			getFW().redirect(action="admin:integration.list", querystring="message=admin.integration.save_success");
		} else {
			getFW().setView(action="admin:integration.detail");
		}
	}
	
}