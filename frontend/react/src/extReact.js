import React, { Component } from 'react'
import { View, Text, Button } from 'react-native'

import React, {Component} from 'react';
import {Text, Button, View} from 'react-native';

export default class App extends Component{
constructor(){
    super();
    this.state = {
    textValue: 'Temporary text'
    }
    this.onPressButton= this.onPressButton.bind(this);
}

onPressButton() {
    this.setState({
        textValue: 'Text has been changed'
    })
}

render(){
    return(

<View style={{paddingTop: 20}}>
  <Text style={{color: 'red',fontSize:20}}> {this.state.textValue} </Text>
  <Button title= 'Change Text' onPress= {this.onPressButton}/>
</View>

   );
 }
}
