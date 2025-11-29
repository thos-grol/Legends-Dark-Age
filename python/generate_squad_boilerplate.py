with open('test.nut', "w") as f_out:
    for i in range(1, 11):
        f_out.write(f"""
        var squad_layout_{i} = $('<div class="l-button is-squad-{i}"/>');
        this.mSquadPanel.append(squad_layout_{i});
        this.BUTTON_SQUAD_{i} = squad_layout_{i}.createTextButton("{i}", function ()
        {{
            self.select_squad({i});
        }}, '', 3);
        """)