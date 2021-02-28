
    import React from 'react';  
    import Drawer from '@material-ui/core/Drawer';  
    import Button from '@material-ui/core/Button';  
    import List from '@material-ui/core/List';  
    import Divider from '@material-ui/core/Divider';  
    import ListItem from '@material-ui/core/ListItem';  
    import ListItemText from '@material-ui/core/ListItemText';  


    export default function DrawerDemo() {  
            const [state, setState] = React.useState({  
                    top: false,  
                    left: false,  
            });  
      
            const toggleDrawer = (side, open) => event => {  
                    if (event.type === 'keydown' && (event.key === 'Tab' || event.key === 'Shift')) {  
                            return;  
                    }  
      
                    setState({ ...state, [side]: open });  
            };  
      
            const sideList = side => (  
                <div  
                        role="presentation"  
                        onClick={toggleDrawer(side, false)}  
                        onKeyDown={toggleDrawer(side, false)}  
                >  
                        <List>  
                                {['Species', 'Watershield', 'Canada Map', 'US Map', 'Add News'].map((text, index) => (  
                                        <ListItem button key={text}>  
                                                <ListItemText primary={text} />  
                                        </ListItem>  
                                ))}  
                        </List>  
                        <Divider />  
                </div>  
            );  
      
            const fullList = side => (  
                <div  
                        role="presentation"  
                        onClick={toggleDrawer(side, false)}  
                        onKeyDown={toggleDrawer(side, false)}  
                >  
                        <List>  
                                {['Fishing', 'News', 'Lake', 'River', 'Creek', 'Channel'].map((text, index) => (  
                                        <ListItem button key={text}>  
                                                <ListItemText primary={text} />  
                                        </ListItem>  
                                ))}  
                        </List>  
                        <Divider />  
                </div>  
            );  
      
            return (  
                <>  
                <div id="menu-content">  
                        <Button color="white" onClick={toggleDrawer('left', true)}>Info</Button>  
                        <Button color="white" onClick={toggleDrawer('top', true)}>Fishing</Button>  
                        <Drawer open={state.left} onClose={toggleDrawer('left', false)}>  
                                {sideList('left')}  
                        </Drawer>  
                        <Drawer anchor="top" open={state.top} onClose={toggleDrawer('top', false)}>  
                                {fullList('top')}  
                        </Drawer>  
                </div>  
                </>  
            );  
    }  
