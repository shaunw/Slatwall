<!---

    Slatwall - An Open Source eCommerce Platform
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

<cfparam name="rc.orderPayment" type="any" />
<cfparam name="rc.order" type="any" />
<cfparam name="rc.paymentMethod" type="any" />
<cfparam name="rc.orderPaymentTypeSystemCode" type="string" />
<cfparam name="rc.edit" type="boolean" default="tr" />

<cfoutput>
	<cf_SlatwallDetailForm object="#rc.orderPayment#" edit="#rc.edit#">
		
		<input type="hidden" name="order.orderID" value="#rc.order.getOrderID()#" />
		<input type="hidden" name="paymentMethod.paymentMethodID" value="#rc.paymentMethod.getPaymentMethodID()#" />
		<input type="hidden" name="process" value="1" />
		
		<cfif rc.orderPaymentTypeSystemCode eq "optCharge">
			<input type="hidden" name="orderPaymentType.typeID" value="444df2f0fed139ff94191de8fcd1f61b" />
		<cfelse>
			<input type="hidden" name="orderPaymentType.typeID" value="444df2f1cc40d0ea8a2de6f542ab4f1d" />
		</cfif>
		
		<cfset local.amount = rc.order.getTotal() - rc.order.getPaymentAmountTotal() />
		<cfif local.amount lt 0>
			<cfset local.amount = local.amount * -1 /> 
		</cfif>
		
		<cf_SlatwallProcessOptionBar>
			<cfif rc.orderPaymentTypeSystemCode eq "optCharge">	
				<cf_SlatwallProcessOption data="transactionType" fieldType="select" valueOptions="#[{value='authorizeAndCharge', name='Authorize & Charge'}, {value='authorize', name='Authorize'}]#" />
			<cfelse>
				<cf_SlatwallProcessOption data="transactionType" fieldType="select" valueOptions="#[{value='credit', name='Credit'}]#" />
			</cfif>
		</cf_SlatwallProcessOptionBar>

		<cf_SlatwallDetailHeader>
			<cf_SlatwallPropertyList divClass="span6">
				<cf_SlatwallAddressDisplay address="#$.slatwall.getService("addressService").newAddress()#" fieldnameprefix="billingAddress." edit="#rc.edit#" />
			</cf_SlatwallPropertyList>
			<cf_SlatwallPropertyList divClass="span6">
				<cfif rc.paymentMethod.getPaymentMethodType() eq "creditCard">
					<cf_SlatwallPropertyDisplay object="#rc.orderPayment#" property="nameOnCreditCard" edit="#rc.edit#" />
					<cf_SlatwallPropertyDisplay object="#rc.orderPayment#" property="creditCardNumber" edit="#rc.edit#" />
					<cf_SlatwallPropertyDisplay object="#rc.orderPayment#" property="expirationMonth" edit="#rc.edit#" />
					<cf_SlatwallPropertyDisplay object="#rc.orderPayment#" property="expirationYear" edit="#rc.edit#" />
					<cf_SlatwallPropertyDisplay object="#rc.orderPayment#" property="securityCode" edit="#rc.edit#" />
					<cf_SlatwallPropertyDisplay object="#rc.orderPayment#" property="amount" edit="#rc.edit#" value="#local.amount#" />	
				</cfif>
			</cf_SlatwallPropertyList>
		</cf_SlatwallDetailHeader>
	</cf_SlatwallDetailForm>
</cfoutput>