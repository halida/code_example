use std::collections::HashMap;

fn main() {
    let route = HashMap::new();
    route.insert("/hello", |request|{
        "hello"
    });
    route.insert("/", |request|{
        "welcome"
    });

    app = App.new(route);
    app.run();
}
