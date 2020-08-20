const io = require('socket.io')(3000);

const rooms = {};
const roomsNames = [];

io.on('connection', socket =>{
    console.log("new user");

    socket.on("user-connection", ()=>{
        socket.emit("rooms", roomsNames)
    });

    socket.on('new-user',(room, name)=>{
        socket.join(room);
        rooms[room].users[socket.id] = name;
        socket.to(room).emit('user-connected', name);
    })

    socket.on('disconnect', () =>{
        getUserRooms(socket).forEach(room => {
            socket.to(room).broadcast.emit("user-disconnected",rooms[room].users[socket.id]);
            delete rooms[room].users[socket.id];
        })
    })
})

function getUserRooms(socket){
    return Object.entries(rooms).reduce((names,[name,room])=>{
        if(room.users[socket.id]!=null)names.push(name);
        return names;
    },[]);
}