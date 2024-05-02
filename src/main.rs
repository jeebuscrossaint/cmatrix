use crossterm::{
    cursor::{Hide, MoveTo},
    execute,
    style::{Color, Print, ResetColor, SetForegroundColor},
    terminal::{self, Clear, ClearType},
};
use rand::Rng;
use std::{thread, time::Duration, io::{stdout, Stdout}};

struct Drop {
    x: u16,
    y: u16,
    length: u16,
}

impl Drop {
    fn new(x: u16, y: u16, length: u16) -> Self {
        Self { x, y, length }
    }

    fn draw(&self, stdout: &mut Stdout) {
        let mut rng = rand::thread_rng();
        for i in 0..self.length {
            if let Some(y) = self.y.checked_sub(i) {
                let char = rng.gen_range(0x0021..0x007F) as u8 as char; // ASCII range for printable characters
                execute!(stdout, MoveTo(self.x, y), SetForegroundColor(Color::Green), Print(char), ResetColor).unwrap();
            }
        }
    }

    fn clear(&self, stdout: &mut Stdout) {
        if let Some(y) = self.y.checked_sub(self.length) {
            execute!(stdout, MoveTo(self.x, y), Clear(ClearType::CurrentLine)).unwrap();
        }
    }

    fn fall(&mut self, height: u16) {
        self.clear(&mut stdout());
        self.y = (self.y + 1) % height;
        self.draw(&mut stdout());
    }
}

fn main() {
    let mut rng = rand::thread_rng();
    let mut stdout = stdout();

    execute!(stdout, Hide).unwrap(); // Hide cursor

    let (width, height) = terminal::size().unwrap();
    let mut drops: Vec<Drop> = (0..width).map(|x| Drop::new(x, rng.gen_range(0..height), rng.gen_range(1..10))).collect();

    loop {
        for drop in &mut drops {
            drop.fall(height);
        }

        thread::sleep(Duration::from_millis(50));
    }
}