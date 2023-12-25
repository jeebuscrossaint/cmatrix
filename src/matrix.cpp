#include <windows.h>
#include <iostream>
#include <ctime>
#include <vector>

#define WIDTH 80
#define HEIGHT 25
#define TRAIL_LENGTH 10

struct Drop {
    int x, y, speed;
    std::vector<int> trail_y;
};

int main() {
    srand(time(0));
    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    COORD coord;
    Drop drops[WIDTH];
    std::vector<std::vector<char>> buffer(HEIGHT, std::vector<char>(WIDTH, ' '));

    // Initialize drops
    for (int i = 0; i < WIDTH; ++i) {
        drops[i].x = i;
        drops[i].y = rand() % HEIGHT;
        drops[i].speed = rand() % 2 + 1;
    }

    while (true) {
        // Clear buffer
        for (auto& row : buffer) {
            std::fill(row.begin(), row.end(), ' ');
        }

        // Update drops and draw them in the buffer
        for (int i = 0; i < WIDTH; ++i) {
            // Draw trail
            for (int j = 0; j < drops[i].trail_y.size(); ++j) {
                if (drops[i].trail_y[j] < HEIGHT) {
                    buffer[drops[i].trail_y[j]][drops[i].x] = ' ';
                }
            }

            // Draw head
            buffer[drops[i].y][drops[i].x] = (char)(rand() % 93 + 33);

            // Move drop
            drops[i].trail_y.insert(drops[i].trail_y.begin(), drops[i].y);
            if (drops[i].trail_y.size() > TRAIL_LENGTH) {
                drops[i].trail_y.pop_back();
            }
            drops[i].y += drops[i].speed;
            if (drops[i].y >= HEIGHT) {
                drops[i].y = 0;
                drops[i].trail_y.clear();
                drops[i].speed = rand() % 2 + 1;
            }
        }

        // Draw buffer to console
        coord.X = 0;
        coord.Y = 0;
        SetConsoleCursorPosition(hConsole, coord);
        SetConsoleTextAttribute(hConsole, FOREGROUND_GREEN | FOREGROUND_INTENSITY); // Set text color to green
        for (const auto& row : buffer) {
            for (char c : row) {
                std::cout << c;
            }
            std::cout << '\n';
        }

        Sleep(100);
    }

    return 0;
}