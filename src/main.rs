use crossterm::{
    cursor::{Hide, MoveTo},
    execute,
    style::{Color, Print, ResetColor, SetForegroundColor},
    terminal::{self, Clear, ClearType},
};
use rand::Rng;
use std::{thread, time::Duration, io::stdout};

fn main() {
    let mut rng = rand::thread_rng();
    let mut stdout = stdout();

    execute!(stdout, Hide).unwrap(); // Hide cursor

    loop {
        let (width, height) = terminal::size().unwrap();
        let x = rng.gen_range(0..width);
        let y = rng.gen_range(0..height);

        execute!(stdout, MoveTo(x, y), SetForegroundColor(Color::Green), Print('█'), ResetColor).unwrap();

        thread::sleep(Duration::from_millis(50));

        execute!(stdout, MoveTo(x, y), Clear(ClearType::CurrentLine)).unwrap();
    }
}