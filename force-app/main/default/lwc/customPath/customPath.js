import { LightningElement, track, wire } from 'lwc';
import getPath from '@salesforce/apex/CustomePath.getPath';

export default class CustomPath extends LightningElement {

    @track pathdata;
    @wire(getPath) linkPathWithPathData({error,data}){
        if (data) {
            console.log(data);
            this.pathdata = data;
        } else if (error) {
            console.log(error);
            this.error = error;
        }
    };

   

    
}