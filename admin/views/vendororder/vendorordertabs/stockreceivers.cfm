<!---

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

--->

<cfparam name="rc.stockReceiverVendorOrderSmartList">

<cfoutput>
	<!---<div class="buttons">
		<cf_SlatwallActionCaller action="admin:stockreceiver.createStockReceiverVendorOrder" text="#$.slatwall.rbKey('admin.stockreceiver.create')#" queryString="vendorOrderID=#rc.VendorOrder.getVendorOrderID()#" class="button" />
	</div>--->
	
	<cfif ArrayLen(rc.stockReceiverVendorOrderSmartList.getRecords()) GT 0>
	
		<table class="listing-grid stripe">
			<tr>
				<th class="varWidth">#$.slatwall.rbKey("entity.stockreceiver.createdDateTime")#</th>
				<th>#$.slatwall.rbKey("entity.stockreceiver.boxCount")#</th>
				<th>#$.slatwall.rbKey("entity.stockreceiver.packingSlipNumber")#</th>
				<th></th>
			</tr>
				
			<cfloop array="#rc.stockReceiverVendorOrderSmartList.getRecords()#" index="local.stockReceiverVendorOrder">
				<tr>
					<td class="varWidth">#DateFormat(local.stockReceiverVendorOrder.getCreatedDateTime(), "medium")#</td>
					<td>#local.stockReceiverVendorOrder.getBoxCount()#</td>
					<td>#local.stockReceiverVendorOrder.getPackingSlipNumber()#</td>
					<td class="administration">
						<ul class="one">
						  <cf_SlatwallActionCaller action="admin:stockReceiver.detailStockReceiver" querystring="stockReceiverID=#local.stockReceiverVendorOrder.getStockReceiverID()#&vendorOrderId=#rc.VendorOrderId#" class="detail" type="list">
						</ul>     						
					</td>
				</tr>
				
			</cfloop>
		</table>
	<cfelse>
		#$.slatwall.rbKey("admin.vendorOrder.detail.tab.stockReceivers.noStockReceivers")#
	</cfif>
	<div class="clear"></div>
</cfoutput>