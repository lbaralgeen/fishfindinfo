import React, {useState, useEffect} from 'react';
import logo from './fslogo.png';
import './App.css';
import TMenu from './TMenu';  
import SocialFollow from "./SocialFollow"

const userStateList = ["owner", "admin", "public", "user", "paid", "science", "robot"];

function Header()
{ 
  const [userState, SetUserState] = useState("public");
  const [logState,  SetLogState]   = useState("Log In");  
  useEffect(() => {
    console.log('This is user state: {userState}');
  }, [userState])


  return (
    <header  className="App-header">
      <div id="logo-content">
        <img src={logo} width="200" alt="Find Fish Info"/>  
      </div>
      <div id="log-content">       
          <button onClick={ ()=> SetLogState(logState)} >
            [{logState}]
          </button>
	    </div>      
      <div></div>
      <div id="social-container">
          <SocialFollow />
      </div>
      <div id="user-content">
          Access: {userState}
      </div>        

    </header>
  );
}

function Main(props)
{
  return (
    <section> 
      <h3> Fish {props.adj} forecast </h3>
      <ul style={{textAlign: "left"}}>
        { props.fishes.map((fish) => 
          <li key={fish.id}>{fish.title}</li>)}
        </ul>
    </section>
  );
}

function Footer(props)
{
  return (
    <section className="App-footer">
      <div className="block-footer">
        <h5>&copy; LB Co 2014-{props.year}. All rights reserved. Developed by C&#64;Chumak</h5>   
      </div>    
    </section>
  );
}
const fishes = ["Carp", "Salmon", "Perch", "Eel"];
const fishObjects = fishes.map((fish, i) => ({id: i, title: fish}));
//console.log(fishObjects);

function App(props) 
{
  return (
    <>
    <div className="App">
      <Header name="Const"  />
      <TMenu/>
       <Main adj="Weather" fishes={fishObjects} />   
      <Footer year={new Date().getFullYear()}/>
    </div>
    </>
  )
}


export default App;
