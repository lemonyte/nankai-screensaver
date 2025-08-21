# Nankai Screensaver

A text-based screensaver that runs in your terminal.

## How to install

1. Clone the repository somewhere on your system
2. Download [nankai.rb](https://github.com/mame/sonny-boy-nankai/blob/main/nankai.rb) and place it in the folder you just cloned
3. `chmod +x *.sh` inside the cloned folder
4. Move the `.desktop` file to your XDG applications folder, usually `~/.local/share/applications/`
5. In that file, change the `Exec=` line to point to the real location of the scripts on your system
6. Link the `.desktop` file into `~/.config/autostart/`
7. Optionally, change the idle time value from 300 seconds (5 minutes) to your preferred duration
8. It is also recommended to increase your display power saving timeout so you can see the screensaver before your display turns off

The script should launch in the background after the next reboot or when you log out and back in.

You can see if it's running with `ps aux | grep "screensaver"`.

> [!IMPORTANT]
> The desktop entry will not show up in your app menu unless the paths in the `Exec=` line are correct absolute paths. Variables and `~` don't work.

## Testing

Before rebooting, you can also test the script by running it manually.

Usage:

```bash
./screensaver.sh <command> <idle_seconds>
```

Example:

```bash
./screensaver.sh ./nankai_loop.sh 2
```

- `screensaver.sh` is the main script that monitors for inactivity, launches the screensaver, and kills it when the computer sleeps or is not idle anymore
- `nankai_loop.sh` runs the actual ASCII animation in a loop
- `2` is the number of seconds to wait before launching the screensaver

## Requirements

This code was written with the assumption of a few dependencies being installed on the system:

- [GNOME](https://www.gnome.org/) desktop environment
- [DBus](https://dbus.freedesktop.org/)
- [Ghostty](https://ghostty.org/) terminal emulator
- [Ruby](https://www.ruby-lang.org/)

### What about my DE or terminal emulator?

You're welcome to fork and adapt the code to your own system :)

If you find a way to make it support multiple desktop environments or terminal emulators, please open a PR!

I would use [xdg-terminal-exec](https://github.com/Vladimir-csp/xdg-terminal-exec), but the `--fullscreen` flag is slightly different for each terminal emulator,
so the script would need to hard-code a bunch of different terminals to figure out the correct flag.

## License

[MIT License](license.txt)
