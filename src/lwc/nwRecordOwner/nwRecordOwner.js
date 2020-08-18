import { LightningElement, api } from 'lwc';
import getRecordOwner from '@salesforce/apex/nw_RecordOwnerCtrl.getRecordOwnerApex';

export default class NwRecordOwner extends LightningElement {

    @api recordId;
    @api objectType;
    recordOwner;

    connectedCallback() {
        console.log('### loading lwc');
        let params = { 
            recordId : this.recordId,
            objectType : this.objectType
        } 
        console.log('### lwc params: ' + JSON.stringify(params));
        getRecordOwner(params).then(result => {
            console.log('### got result: ' + JSON.stringify(result));
            this.recordOwner = result;
        }).catch(error => {
            console.log('ERROR: ', error); 
        });
    }
}