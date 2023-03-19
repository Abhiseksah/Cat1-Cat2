import { LightningElement, track, wire, api } from 'lwc';
import getContractsRelatedToAccount from '@salesforce/apex/OverviewOfContractCtrl.getContractsRelatedToAccount';
import getSubsRelatedToAccount from '@salesforce/apex/OverviewOfContractCtrl.getSubsRelatedToAccount';
export default class OverviewOfContract extends LightningElement {
    @api recordId;
    @track contracts;
    @track subs;
    @track subs2;
    @track error;
    @track ownerInfo = [
        { label: 'First Name', fieldName: 'ownerName', type: 'text' },
        { label: 'Phone', fieldName: 'OwnerPh', type: 'phone' },
        { label: 'Address', fieldName: 'ownerAdd', type: 'text' }
        
    ];
    @track productInfo = [
        { label: 'Product Name', fieldName: 'Name', type: 'text' },
        { label: 'Quantity', fieldName: 'quantity', type: 'number' },
        { label: 'Net Price', fieldName: 'SBQQ__NetPrice__c', type: 'text' },
        { label: 'Owner First Name', fieldName: 'ownerName', type: 'text' },
        { label: 'Phone', fieldName: 'OwnerPh', type: 'phone' },
        { label: 'Address', fieldName: 'ownerAdd', type: 'text' }
        

    ];
    @track ownerAddress = [
        { label: 'Billing Address', fieldName: 'ownerAdd', type: 'text' },
        { label: 'Shipping Address', fieldName: 'shippingAdd', type: 'text' }
    ];

    
    
/*
    @wire(getContractsRelatedToAccount, {accId: '$recordId'}) 
    WireContactRecords({error, data}){
        if(data){
            this.contracts = data;
            console.log('contract if part'+data);
            this.error = undefined;
        }else{
            this.error = error;
            console.log('contract if part'+error);
            this.contracts = undefined;
        }
    }
    handleLoad() {
    getContractsRelatedToAccount()
            .then(result => {
                this.contracts = result;
            })
            .catch(error => {
                this.error = error;
            });
    } */
    @wire(getSubsRelatedToAccount, {accId2: '$recordId'}) 
    WireContactRecords2({error, data}){
        if(data){
            console.log('data under if'+data);

            let tempRecords = JSON.parse( JSON.stringify( data ) );
            tempRecords = tempRecords.map( row => {
                return {  Name: row.SBQQ__Product__r.Name ,SBQQ__NetPrice__c:row.SBQQ__NetPrice__c,
                    quantity: row.SBQQ__Quantity__c,
                    ownerName: row.SBQQ__Account__r.Name,OwnerPh: row.SBQQ__Account__r.Phone,
                    ownerAdd: row.SBQQ__Account__r.BillingAdd__c,
                    shippingAdd: row.SBQQ__Account__r.ShippingAdd__c

                        };
            })
            

            this.subs = tempRecords;
            this.subs2 = tempRecords;
            console.log('subs if part'+tempRecords);
            this.error = undefined;
        }else{
            this.error = error;
            console.log('subs error part'+error);
            this.contracts = undefined;
        }
    }
}