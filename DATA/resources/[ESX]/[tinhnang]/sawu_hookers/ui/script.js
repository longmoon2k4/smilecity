const SAWU_Hookers = new Vue({
    el: "#SAWU_Hookers",

    data: {
        // Shared
        ResourceName: "SAWU_Hookers",
        showHookersSelector: false,
        showPimpSelector: false,
        blowjob: null,
        sex: null,

    },

    methods: {

        // START OF MAIN MENU
        OpenPimpMenu() {
            this.showPimpSelector       = true;
            this.showHookersSelector    = false;

        },

        OpenHookersMenu(blowjob, sex) {
            this.showHookersSelector    = true;
            this.showPimpSelector       = false;
            this.blowjob                = blowjob;
            this.sex                    = sex;

        },

        CloseHookersMenu() {
            axios.post(`http://${this.ResourceName}/CloseMenu`, {}).then((response) => {
                this.showHookersSelector    = false;
                this.showPimpSelector       = false;
            }).catch((error) => { });
        },

        ChooseCathrine() {
            axios.post(`http://${this.ResourceName}/ChooseCathrine`, {}).then((response) => {
                this.showHookersSelector    = false;
                this.showPimpSelector       = false;
            }).catch((error) => { });
        },

        ChooseTatiana() {
            axios.post(`http://${this.ResourceName}/ChooseTatiana`, {}).then((response) => {
                this.showHookersSelector    = false;
                this.showPimpSelector       = false;
            }).catch((error) => { });
        },

        ChooseBootylicious() {
            axios.post(`http://${this.ResourceName}/ChooseBootylicious`, {}).then((response) => {
                this.showHookersSelector    = false;
                this.showPimpSelector       = false;
            }).catch((error) => { });
        },

        ChooseVennesa() {
            axios.post(`http://${this.ResourceName}/ChooseVennesa`, {}).then((response) => {
                this.showHookersSelector    = false;
                this.showPimpSelector       = false;
            }).catch((error) => { });
        },

        ChooseBlowjob() {
            axios.post(`http://${this.ResourceName}/ChooseBlowjob`, {}).then((response) => {
                this.showHookersSelector    = false;
                this.showPimpSelector       = false;
            }).catch((error) => { });
        },

        ChooseSex() {
            axios.post(`http://${this.ResourceName}/ChooseSex`, {}).then((response) => {
                this.showHookersSelector    = false;
                this.showPimpSelector       = false;
            }).catch((error) => { });
        },

        CloseServiceMenu() {
            axios.post(`http://${this.ResourceName}/CloseServiceMenu`, {}).then((response) => {
                this.showHookersSelector    = false;
                this.showPimpSelector       = false;
            }).catch((error) => { });
        },


    },
});

// Listener from Lua CL
document.onreadystatechange = () => {
    if (document.readyState == "complete") {
        var audioBlow = document.getElementById("blowjob");
        var audioFinal = document.getElementById("final");
        window.addEventListener("message", (event) => {
            if (event.data.type == "openPimpMenu") {
                SAWU_Hookers.OpenPimpMenu(event.data.blowjob, event.data.sex);
            } else if (event.data.type == "openHookerMenu") {
                SAWU_Hookers.OpenHookersMenu(event.data.blowjob, event.data.sex);
            }else if (event.data.type == "soundBlow") {
                audioBlow.play()
            }else if (event.data.type == "soundFinal") {
                audioFinal.play()
            }
        });
    }
}
