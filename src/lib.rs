pub fn hello_world() {
    println!("Hello World");
}

pub fn return_true() -> bool {
    true
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn return_true_test() {
        assert_eq!(true, return_true());
    }
}