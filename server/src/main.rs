use message_io::node::{self, NodeEvent};
use message_io::network::{NetEvent, Transport};

use arrow_cli::Command;

fn main() {
    let (handler, listener) = node::split();
    let (server, _) = handler.network().connect(Transport::FramedTcp, "127.0.0.1:3042").unwrap();

    listener.for_each(move | event| match event {
        NodeEvent::Network(net_event) => match net_event {
            NetEvent::Connected(endpoint, _ok) => {
                println!("Connected to {}", endpoint.addr());
                handler.signals().send( Command::Greet)
            },
            NetEvent::Accepted(_, _) => unreachable!(),
            NetEvent::Message(_endpoint, data) => {
                println!("Received message: {}", String::from_utf8_lossy(data));
            },
            NetEvent::Disconnected(_endpoint) => (),
        },
        NodeEvent::Signal(signal) => match signal {
            Command::Greet => { 
                handler.network().send(
                    server, 
                    "Hello server!".as_bytes()
                );
            }
        }
    });
}
