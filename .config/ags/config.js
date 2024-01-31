import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

/////// Workspaces
function WorkBar(monitor) {
    console.log(monitor);
    let workmon = 0;
    let workbarname = 'workbar-' + monitor;

    if (monitor > 0) {
        workmon = monitor * 10 + 1;
        console.log('if monitor is not zero works');
    } else {
        workmon = 1;
        console.log('if monitor is zero works');
    }

    const WorkspaceButton = (i) => Widget.EventBox({
        class_name: "ws-button",
        on_primary_click_release: () => Hyprland.sendMessage(`dispatch workspace ${i}`),
        child: Widget.Label({
            label: `.`,
            class_name: "ws-button-label"
        })
    })
          .hook(Hyprland.active.workspace, (button) => {
              button.toggleClassName("active", Hyprland.active.workspace.id === i);
          });

    const Workspaces = () => Widget.EventBox({
        on_scroll_up: () => Hyprland.sendMessage(`dispatch workspace -1`),
        on_scroll_down: () => Hyprland.sendMessage(`dispatch workspace +1`),
        child: Widget.Box({
            class_name: "ws-container",
            children: Array.from({length: 9}, (_, i) => i + workmon).map(i => WorkspaceButton(i)),
        })
            .hook(Hyprland, (box) => {
                box.children.forEach((button, i) => {
                    const ws = Hyprland.getWorkspace(i + workmon);
                    button.toggleClassName("occupied", ws?.windows > 0);
                });
            }, "notify::workspaces")
    });

    const Workspacebar = () => Widget.Box({
        children: [
            Workspaces(),
        ],
    });

    const WorkspaceBar = () => Widget.Window({
        name: workbarname, // name has to be unique
        class_name: 'workbar',
        monitor: monitor,
        anchor: ['top'],
        exclusivity: 'ignore',
        layer: 'top',
        child: Widget.CenterBox({
            center_widget: Workspacebar(),
        }),
    });

    return WorkspaceBar();
};

/////// Date and time
const Date = () => Widget.Label({
    class_name: 'date',
    setup: self => self
        .poll(60000, self => execAsync(['date', '+%a %b %d'])
            .then(date => self.label = date)),
});

const Clock = () => Widget.Label({
    class_name: 'clock',
    setup: self => self
        .poll(1000, self => execAsync(['date', '+%H:%M:%S'])
            .then(date => self.label = date)),
});

/////// Media and volume
const Media = () => Widget.Button({
    class_name: 'media',
    on_primary_click: () => Mpris.getPlayer('')?.playPause(),
    on_scroll_up: () => Mpris.getPlayer('')?.next(),
    on_scroll_down: () => Mpris.getPlayer('')?.previous(),
    child: Widget.Label('-').hook(Mpris, self => {
        if (Mpris.players[0]) {
            const { track_artists, track_title } = Mpris.players[0];
            self.label = `${track_artists.join(', ')} - ${track_title}`;
        } else {
            self.label = 'Nothing is playing';
        }
    }, 'player-changed'),
});

const Volume = () => Widget.Box({
    class_name: 'volume',
    children: [
        Widget.Icon().hook(Audio, self => {
            if (!Audio.speaker)
                return;

            const category = {
                101: 'overamplified',
                67: 'high',
                34: 'medium',
                1: 'low',
                0: 'muted',
            };

            const icon = Audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
                threshold => threshold <= Audio.speaker.volume * 100);

            self.icon = `audio-volume-${category[icon]}-symbolic`;
        }, 'speaker-changed'),
        Widget.Label({
            setup: self => self
                .hook(Audio, label => {
                    if (Audio.speaker)
                        label.label = `${Math.floor(Audio.speaker.volume * 100)}%`;
                }, 'speaker-changed'),
        }),
    ],
});

const SysTray = () => Widget.Box({
    children: SystemTray.bind('items').transform(items => {
        return items.map(item => Widget.Button({
            child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            binds: [['tooltip-markup', item, 'tooltip-markup']],
        }));
    }),
});

/////// layout of the bar
const Center = () => Widget.Box({
    spacing: 8,
    children: [
        Media(),
        Volume(),
        Date(),
        Clock(),
        SysTray(),
    ],
});

const Bar = (monitor = 0) => Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: 'bar',
    monitor,
    anchor: ['bottom'],
    exclusivity: 'ignore',
    layer: 'overlay',
    child: Widget.CenterBox({
        center_widget: Center(),
    }),
});

import { monitorFile } from 'resource:///com/github/Aylur/ags/utils.js';

monitorFile(
    `${App.configDir}/style.css`,
    function() {
        App.resetCss();
        App.applyCss(`${App.configDir}/style.css`);
    },
);

// exporting the config so ags can manage the windows
export default {
    style: App.configDir + '/style.css',
    windows: [
        Bar(),
        WorkBar(0),
        WorkBar(1),
        WorkBar(2),

        // you can call it, for each monitor
        // Bar(0),
        // Bar(1)
    ],
};
