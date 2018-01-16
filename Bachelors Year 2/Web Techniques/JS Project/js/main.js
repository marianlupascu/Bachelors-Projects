var enemies = [];
var allies = [];
var moviesWallpaper = [];
var sounds = [];
var player = null;
var backgroundsSrc = [];
var HEIGHT_CHARACTER = 175; // from main.css
var NUMBEROFRESOURCES = 0;
var nameOfXMLfile = "xml/main.xml";
var volumeFromInput = null;
var firstNameFromInput = null;
var lastNameFromInput = null;
var countryFromInput = null;
var colorsFromInput = [];
var ageFromInput = null;
var personagesFromInput = [];
var difucultyFromInput = null;
var backgroundFromInput = null;
var InputOk = false;
var level = 1;
var currentMovie = 0;
var score = null;

class Sound {
    // Getter
    get HTML() {
        return this.HTLMElem;
    }

    constructor(elem) {
        this.HTLMElem = elem;
    }

    // Method
    play() {
        this.HTLMElem.play();
    }
}

window.onload = function Main() {

    try {
        getNumberOfResources(nameOfXMLfile);
        $(document).ajaxComplete(parseResources(nameOfXMLfile));
    }
    catch (err) {
        console.log(err.message);
        alert(err.message);
    }
};

function Rest() {
    clearProgressBar();
    appendProgressBartoCharacters();
    setMenuScreen();
    //seeCharacters();
}

function setMenuScreen() {
    var elem = document.getElementsByClassName("containerMenu")[0];
    elem.style.display = "block";
}

function hiddenMenuScreen() {
    var elem = document.getElementsByClassName("containerMenu")[0];
    elem.style.display = "none";
}

function clearProgressBar() {
    var elem = document.getElementsByClassName("backgroundProgressBar")[0];
    document.body.removeChild(elem);
}

function getNumberOfResources(xmlFileName) {
    $(document).ready(function () {
        $.ajax({
            url: xmlFileName,
            type: "GET",
            dataType: "xml",
            success: function (xml) {
                var numberOfResources = 0;
                $xml = $(xml);
                $images = $xml.find("image");
                numberOfResources += $images.length;

                $sounds = $xml.find("sound");
                numberOfResources += $sounds.length;

                $videos = $xml.find("video");
                numberOfResources += $videos.length;

                NUMBEROFRESOURCES = numberOfResources;
                return numberOfResources;
            },
            error: function (err) {
                alert(err);
            }
        });
    });
}

function parseResources(xmlFileName) {
    //getNumberOfResources(xmlFileName);
    $(document).ready(function () {
        $.ajax({
            url: xmlFileName,
            type: "GET",
            dataType: "xml",
            success: function (xml) {
                var curentNumberOfResources = 0;
                $xml = $(xml);
                $images = $xml.find("image");
                $images.each(function (i) {

                    curentNumberOfResources++;
                    upgradeProgressBar(curentNumberOfResources);
                    var img = $("<div></div>");
                    var text = $(this).text();
                    img.get(0).style.backgroundImage = "url(" + text + ")";
                    img.attr("id", $(this).attr("id"));
                    var type = $(this).attr("type");
                    switch (type) {
                        case 'background' :
                            backgroundsSrc.push(text);
                            //var bg = document.getElementById("backgroundGame");
                            //bg.style.backgroundImage = 'url(' + text + ')';
                            break;
                        case 'opponent' :
                            var w = $(this).attr("w");
                            var h = $(this).attr("h");
                            img.get(0).style.width = w * (HEIGHT_CHARACTER / h) + 'px';
                            img.attr("class", "character opponent");
                            enemies.push(img.get(0));
                            break;
                        case 'ally' :
                            var w = $(this).attr("w");
                            var h = $(this).attr("h");
                            img.get(0).style.width = w * (HEIGHT_CHARACTER / h) + 'px';
                            img.attr("class", "character ally");
                            allies.push(img.get(0));
                            break;
                        case 'player' :
                            var w = $(this).attr("w");
                            var h = $(this).attr("h");
                            img.get(0).style.width = w * (HEIGHT_CHARACTER / h) + 'px';
                            img.attr("class", "character player");
                            img.id = "player";
                            player = img.get(0);
                            break;
                        case 'movie' :
                            moviesWallpaper.push(text);
                            break;
                    }
                });

                $sounds = $xml.find("sound");
                $sounds.each(function (i) {

                    curentNumberOfResources++;
                    upgradeProgressBar(curentNumberOfResources);
                    var sound = $("<audio></audio>");
                    var source = $("<source>");
                    var text = $(this).text();
                    source.get(0).src = text;
                    source.get(0).type = "audio/mp3";
                    sound.attr("id", $(this).attr("id"));
                    $(sound).append(source);
                    var type = $(this).attr("type");
                    switch (type) {
                        case 'dead' :
                            sounds.push(new Sound(sound.get(0)));
                            break;
                        case 'next_level' :
                            sounds.push(new Sound(sound.get(0)));
                            break;
                    }
                });


                var elem = document.getElementById("progressBar");
                var elemP = document.getElementById("progressCount");
                elem.style.width = 100 + '%';
                elemP.innerHTML = 100 + "%";
                Rest();
            },
            error: function (err) {
                alert(err);
            }
        });
    });
}

function upgradeProgressBar(percent) {
    var start = percent - 1;
    var end = percent;
    end = (end / NUMBEROFRESOURCES) * 100;
    end = parseInt(end.toString());
    start = (start / NUMBEROFRESOURCES) * 100;
    start = parseInt(start.toString());
    var elem = document.getElementById("progressBar");
    var elemP = document.getElementById("progressCount");
    var id = setInterval(frame(), 10);

    function frame() {
        if (start >= end) {
            clearInterval(id);
        } else {
            start++;
            elem.style.width = start + '%';
            elemP.innerHTML = start + "%";
        }
    }
}

function appendProgressBartoCharacters() {

    for (var i = 0; i < enemies.length; i++) {
        var progressContainer = document.createElement("DIV");
        progressContainer.className = "progressContainer";
        var progress = document.createElement("DIV");
        progress.className = "progressLife";
        progressContainer.appendChild(progress);

        enemies[i].appendChild(progressContainer);
    }
    for (var i = 0; i < allies.length; i++) {
        var progressContainer = document.createElement("DIV");
        progressContainer.className = "progressContainer";
        var progress = document.createElement("DIV");
        progress.className = "progressLife";
        progressContainer.appendChild(progress);

        allies[i].appendChild(progressContainer);
    }
    var progressContainer = document.createElement("DIV");
    progressContainer.className = "progressContainer";
    var progress = document.createElement("DIV");
    progress.className = "progressLife";
    progressContainer.appendChild(progress);

    player.appendChild(progressContainer);
}

function seeCharacters() {
    var bg = document.getElementById("backgroundGame");
    var d = 0;
    for (var i = 0; i < enemies.length; i++) {
        enemies[i].style.marginTop = 20 + 'px';
        enemies[i].style.marginLeft = d + 'px';
        d += parseInt(enemies[i].style.width);
        bg.appendChild(enemies[i]);
    }
    d = 0;
    for (var i = 0; i < allies.length; i++) {
        allies[i].style.marginLeft = d + 'px';
        d += parseInt(allies[i].style.width);
        allies[i].style.marginTop = 220 + 'px';
        bg.appendChild(allies[i]);
    }
    player.style.marginTop = 420 + 'px';
    bg.appendChild(player);
}

function setLogo() {
    var logo = document.getElementById("logo");
    logo.style.display = "block";
}

function unsetLogo() {
    var logo = document.getElementById("logo");
    logo.style.display = "none";
}

function setMenuButton() {
    var elem = document.getElementById("menuButton").children[0];
    elem.style.display = "block";
}

function unsetMenuButton() {
    var elem = document.getElementById("menuButton").children[0];
    elem.style.display = "none";
}

function exitToMenu() {
    setLogo();
    unsetMenuButton();
    setMenuScreen();
    var logo = document.getElementsByClassName("credits");
    if (logo[0] !== undefined) {
        //console.log(logo[0]);
        document.body.removeChild(logo[0]);
    }
    var tutorials = document.getElementsByClassName("tutorials");
    if (tutorials[0] !== undefined) {
        //console.log(tutorials[0]);
        document.body.removeChild(tutorials[0]);
    }
    var options = document.getElementsByClassName("options");
    if (options[0] !== undefined) {
        //console.log(options[0]);
        options[0].style.display = "none";
    }
    var bg = document.getElementById("backgroundGame");
    if (bg.style.display === "block") {
        //console.log(bg);
        bg.style.display = "none";
        while (bg.hasChildNodes()) {
            bg.removeChild(bg.lastChild);
        }

        var divTv = document.createElement("DIV");
        divTv.id = 'tv';
        bg.appendChild(divTv);
        var p = document.createElement("p");
        p.id = "score";
        p.innerHTML = "Score: ";
        var span = document.createElement("SPAN");
        span.id = "scoreValue";
        span.innerText = "0";
        p.appendChild(span);
        bg.appendChild(p);
        updateLives();
    }
}

function updateLives() {

    for (var i = 0; i < enemies.length; i++) {
        var elem = enemies[i].getElementsByClassName("progressLife")[0];
        elem.style.width = 100 + '%';
    }

    for (var i = 0; i < allies.length; i++) {
        var elem = allies[i].getElementsByClassName("progressLife")[0];
        elem.style.width = 100 + '%';
    }
    var elem = player.getElementsByClassName("progressLife")[0];
    elem.style.width = 100 + '%';

    clearInterval(setBulletAtomic);
    level = 1;
}

function seeCredits() {
    hiddenMenuScreen();
    setMenuButton();
    unsetLogo();

    var elem = document.createElement("SECTION");
    elem.className = "credits";
    elem.style.backgroundImage = "url('img/LOGO LM.png')";
    elem.style.position = "absolute";
    elem.style.backgroundSize = "100% 100%";
    elem.style.width = "100%";
    elem.style.height = "100%";
    elem.style.textAlign = "right";
    elem.style.fontFamily = "Neuropol";
    elem.style.color = "white";
    elem.style.fontSize = "3.5rem"

    var p = document.createElement("P");
    p.innerText = "Credits";
    p.style.textAlign = "center";
    p.style.margin = "auto";
    p.style.marginTop = "7.5%";
    elem.appendChild(p);

    var info = document.createElement("P");
    info.style.fontSize = .5 + 'em';
    info.innerText = "Best Score " + localStorage.getItem("heighscore") + ", date " + localStorage.getItem("heighscoreDate");
    info.style.textAlign = "center";
    info.style.margin = "auto";
    info.style.marginTop = "1%";
    elem.appendChild(info);

    document.body.insertBefore(elem, document.body.children[0]);
}

function seeTutorials() {
    hiddenMenuScreen();
    setMenuButton();
    unsetLogo();

    var elem = document.createElement("SECTION");
    elem.className = "tutorials";

    var video = document.createElement("VIDEO");
    video.autoplay = true;
    video.loop = "";
    video.id = "infinityWar";
    video.poster = "http://i.imgur.com/4fSexGQ.jpg";
    video.volume = .1;

    var source = document.createElement("SOURCE");
    source.type = "video/mp4";
    source.src = "video/AvengersInfinityWar.mp4";
    source.autoPlay = true;
    video.appendChild(source);

    var img = document.createElement("IMG");
    img.src = "http://i.imgur.com/4fSexGQ.jpg";
    img.title = "Your browser does not support the <video> tag";
    video.appendChild(img);
    video.appendChild(document.createTextNode("Your browser does not support the <video> tag"));

    elem.appendChild(video);

    var div = document.createElement("DIV");
    div.className = "overlay";
    var h1 = document.createElement("H1");
    h1.appendChild(document.createTextNode("Avengers: Infinity War"));
    var p = document.createElement("P");
    p.appendChild(document.createTextNode("Răzbunătorii: Războiul Infinitului este un film american cu super-eroi, " +
        "care se folosește de echipa de supereroi Marvel Comics, Răzbunătorii, filmul fiind produs de Marvel " +
        "Studios și distribuit de Walt Disney Studios Motion Pictures."));
    div.appendChild(h1);
    div.appendChild(p);

    elem.appendChild(div);

    document.body.appendChild(elem);
}

function seeOptions() {
    hiddenMenuScreen();
    setMenuButton();
    unsetLogo();

    var options = document.getElementsByClassName("options");
    if (options[0] !== undefined) {
        //console.log(options[0]);
        options[0].style.display = "block";

        var buttonSubmit = options[0].getElementsByClassName("completeSubmit")[0];
        //console.log(buttonSubmit);
        if (buttonSubmit !== undefined)
            buttonSubmit.classList.remove("completeSubmit");
    }
    else {
        var elem = document.createElement("SECTION");
        elem.className = "options";
        var h1 = document.createElement("H1");
        h1.appendChild(document.createTextNode("OPTIONS"));
        elem.appendChild(h1);
        {
            var volumeRange = document.createElement("DIV");
            volumeRange.className = "volumeRange";

            var h2 = document.createElement("H2");
            h2.appendChild(document.createTextNode("Volume: "));
            var span = document.createElement("SPAN");
            span.id = "volumeSpan";
            span.innerText = " ";
            h2.appendChild(span);
            volumeRange.appendChild(h2);

            var div = document.createElement("DIV");
            div.className = "slidecontainer";
            var input = document.createElement("INPUT");
            input.type = "range";
            input.min = "0";
            input.max = "100";
            input.value = "50";
            input.className = "slider";
            input.onmouseup = function () {
                this.style.backgroundColor = "#d3d3d3";
            };
            input.onmousedown = function () {
                this.style.backgroundColor = "white";
            };
            input.id = "rangeVolume";
            div.appendChild(input);
            volumeRange.appendChild(div);
            elem.appendChild(volumeRange);
        }

        {
            var info = document.createElement("DIV");
            info.className = "information";

            var h2 = document.createElement("H2");
            h2.appendChild(document.createTextNode("About you..."));
            info.appendChild(h2);

            var div = document.createElement("DIV");
            div.className = "formular";

            {
                var label = document.createElement("LABEL");
                label.for = "fname";
                label.appendChild(document.createTextNode("*First Name"));

                var input = document.createElement("INPUT");
                input.type = "text";
                input.id = "fname";
                input.name = "firstname";
                input.placeholder = "Your name...";
                div.appendChild(label);
                div.appendChild(input);

            }

            {
                var label = document.createElement("LABEL");
                label.for = "lname";
                label.appendChild(document.createTextNode("*Last Name"));

                var input = document.createElement("INPUT");
                input.type = "text";
                input.id = "lname";
                input.name = "lastname";
                input.placeholder = "Your last name...";
                div.appendChild(label);
                div.appendChild(input);
            }

            {
                var label = document.createElement("LABEL");
                label.for = "country";
                label.appendChild(document.createTextNode("Country"));

                var select = document.createElement("SELECT");
                select.id = "country";
                select.name = "country";

                var option1 = document.createElement("OPTION");
                option1.value = "australia";
                option1.appendChild(document.createTextNode("Australia"));
                select.appendChild(option1);

                var option2 = document.createElement("OPTION");
                option2.value = "france";
                option2.appendChild(document.createTextNode("France"));
                select.appendChild(option2);

                var option3 = document.createElement("OPTION");
                option3.value = "romania";
                option3.appendChild(document.createTextNode("Romania"));
                select.appendChild(option3);

                var option4 = document.createElement("OPTION");
                option4.value = "other";
                option4.appendChild(document.createTextNode("Other"));
                select.appendChild(option4);

                div.appendChild(label);
                div.appendChild(select);
            }

            {
                var label = document.createElement("LABEL");
                label.for = "colors";
                label.appendChild(document.createTextNode("*Colors"));

                var select = document.createElement("SELECT");
                select.id = "colors";
                select.name = "colors";
                select.multiple = true;

                var option1 = document.createElement("OPTION");
                option1.value = "blue";
                option1.appendChild(document.createTextNode("Blue"));
                select.appendChild(option1);

                var option2 = document.createElement("OPTION");
                option2.value = "red";
                option2.appendChild(document.createTextNode("Red"));
                select.appendChild(option2);

                var option3 = document.createElement("OPTION");
                option3.value = "yellow";
                option3.appendChild(document.createTextNode("Yellow"));
                select.appendChild(option3);

                var option4 = document.createElement("OPTION");
                option4.value = "green";
                option4.appendChild(document.createTextNode("Green"));
                select.appendChild(option4);

                div.appendChild(label);
                div.appendChild(select);
            }

            {
                var label = document.createElement("LABEL");
                label.for = "age";
                label.appendChild(document.createTextNode("Age "));

                var textarea = document.createElement("TEXTAREA");
                textarea.rows = "1";
                textarea.columns = "3";
                textarea.id = "textareaAge";
                div.appendChild(label);
                div.appendChild(textarea);

            }

            info.appendChild(div);
            elem.appendChild(info);
        }

        {
            var pers = document.createElement("DIV");
            pers.className = "personages";

            var h2 = document.createElement("H2");
            h2.appendChild(document.createTextNode("Personages: "));
            pers.appendChild(h2);

            var div = document.createElement("DIV");

            var label1 = document.createElement("LABEL");
            label1.className = "containerCheckBox";
            label1.appendChild(document.createTextNode("Spider Man & Doctor Octopus"));
            var input1 = document.createElement("INPUT");
            input1.type = "checkbox";
            input1.checked = true;
            personagesFromInput.push(0);
            var span1 = document.createElement("SPAN");
            span1.className = "checkmark";
            label1.appendChild(input1);
            label1.appendChild(span1);
            div.appendChild(label1);

            var label2 = document.createElement("LABEL");
            label2.className = "containerCheckBox";
            label2.appendChild(document.createTextNode("DeadPool & Colossus"));
            var input2 = document.createElement("INPUT");
            input2.type = "checkbox";
            var span2 = document.createElement("SPAN");
            span2.className = "checkmark";
            label2.appendChild(input2);
            label2.appendChild(span2);
            div.appendChild(label2);

            var label3 = document.createElement("LABEL");
            label3.className = "containerCheckBox";
            label3.appendChild(document.createTextNode("Iron Man & Whiplash"));
            var input3 = document.createElement("INPUT");
            input3.type = "checkbox";
            var span3 = document.createElement("SPAN");
            span3.className = "checkmark";
            label3.appendChild(input3);
            label3.appendChild(span3);
            div.appendChild(label3);

            var label4 = document.createElement("LABEL");
            label4.className = "containerCheckBox";
            label4.appendChild(document.createTextNode("Captain America & Red Skull"));
            var input4 = document.createElement("INPUT");
            input4.type = "checkbox";
            var span4 = document.createElement("SPAN");
            span4.className = "checkmark";
            label4.appendChild(input4);
            label4.appendChild(span4);
            div.appendChild(label4);

            var label5 = document.createElement("LABEL");
            label5.className = "containerCheckBox";
            label5.appendChild(document.createTextNode("Thor & Loki"));
            var input5 = document.createElement("INPUT");
            input5.type = "checkbox";
            var span5 = document.createElement("SPAN");
            span5.className = "checkmark";
            label5.appendChild(input5);
            label5.appendChild(span5);
            div.appendChild(label5);

            pers.appendChild(div);
            elem.appendChild(pers);
        }

        {
            var dificulty = document.createElement("DIV");
            dificulty.className = "dificulty";

            var h2 = document.createElement("H2");
            h2.appendChild(document.createTextNode("Dificulty:"));
            dificulty.appendChild(h2);

            var div = document.createElement("DIV");
            div.className = "datalistcontainer";
            var input = document.createElement("INPUT");
            input.setAttribute("list", "dificulty");
            // input.list = "dificulty";
            input.name = "dificulty";
            input.className = "datalist";

            var datalist = document.createElement("DATALIST");
            datalist.id = "dificulty";

            var option1 = document.createElement("OPTION");
            option1.value = "Hard";
            datalist.appendChild(option1);

            var option2 = document.createElement("OPTION");
            option2.value = "Normal";
            datalist.appendChild(option2);

            var option3 = document.createElement("OPTION");
            option3.value = "Easy";
            datalist.appendChild(option3);

            div.appendChild(input);
            div.appendChild(datalist);
            dificulty.appendChild(div);
            elem.appendChild(dificulty);
        }

        {
            var backgrounds = document.createElement("DIV");
            backgrounds.className = "backgrounds";

            var h2 = document.createElement("H2");
            h2.appendChild(document.createTextNode("Backgrounds: "));
            backgrounds.appendChild(h2);

            var div = document.createElement("DIV");

            var label1 = document.createElement("LABEL");
            label1.className = "containerRadio";
            var img1 = document.createElement("DIV");
            img1.className = "imag";
            img1.style.backgroundImage = 'url(' + backgroundsSrc[0] + ')';
            label1.appendChild(document.createTextNode("1:"));
            label1.appendChild(img1);
            var input1 = document.createElement("INPUT");
            input1.type = "radio";
            input1.name = "radio";
            input1.checked = "checked";
            backgroundFromInput = 0;
            var span1 = document.createElement("SPAN");
            span1.className = "checkmarkRadio";
            label1.appendChild(input1);
            label1.appendChild(span1);
            div.appendChild(label1);

            var label2 = document.createElement("LABEL");
            label2.className = "containerRadio";
            var img2 = document.createElement("DIV");
            img2.className = "imag";
            img2.style.backgroundImage = 'url(' + backgroundsSrc[1] + ')';
            label2.appendChild(document.createTextNode("2:"));
            label2.appendChild(img2);
            var input2 = document.createElement("INPUT");
            input2.type = "radio";
            input2.name = "radio";
            var span2 = document.createElement("SPAN");
            span2.className = "checkmarkRadio";
            label2.appendChild(input2);
            label2.appendChild(span2);
            div.appendChild(label2);

            var label3 = document.createElement("LABEL");
            label3.className = "containerRadio";
            var img3 = document.createElement("DIV");
            img3.className = "imag";
            img3.style.backgroundImage = 'url(' + backgroundsSrc[2] + ')';
            label3.appendChild(document.createTextNode("3:"));
            label3.appendChild(img3);
            var input3 = document.createElement("INPUT");
            input3.type = "radio";
            input3.name = "radio";
            var span3 = document.createElement("SPAN");
            span3.className = "checkmarkRadio";
            label3.appendChild(input3);
            label3.appendChild(span3);
            div.appendChild(label3);

            var label4 = document.createElement("LABEL");
            label4.className = "containerRadio";
            var img4 = document.createElement("DIV");
            img4.className = "imag";
            img4.style.backgroundImage = 'url(' + backgroundsSrc[3] + ')';
            label4.appendChild(document.createTextNode("4:"));
            label4.appendChild(img4);
            var input4 = document.createElement("INPUT");
            input4.type = "radio";
            input4.name = "radio";
            var span4 = document.createElement("SPAN");
            span4.className = "checkmarkRadio";
            label4.appendChild(input4);
            label4.appendChild(span4);
            div.appendChild(label4);

            var label5 = document.createElement("LABEL");
            label5.className = "containerRadio";
            var img5 = document.createElement("DIV");
            img5.className = "imag";
            img5.style.backgroundImage = 'url(' + backgroundsSrc[4] + ')';
            label5.appendChild(document.createTextNode("5:"));
            label5.appendChild(img5);
            var input5 = document.createElement("INPUT");
            input5.type = "radio";
            input5.name = "radio";
            var span5 = document.createElement("SPAN");
            span5.className = "checkmarkRadio";
            label5.appendChild(input5);
            label5.appendChild(span5);
            div.appendChild(label5);

            var label6 = document.createElement("LABEL");
            label6.className = "containerRadio";
            var img6 = document.createElement("DIV");
            img6.className = "imag";
            img6.style.backgroundImage = 'url(' + backgroundsSrc[5] + ')';
            label6.appendChild(document.createTextNode("6:"));
            label6.appendChild(img6);
            var input6 = document.createElement("INPUT");
            input6.type = "radio";
            input6.name = "radio";
            var span6 = document.createElement("SPAN");
            span6.className = "checkmarkRadio";
            label6.appendChild(input6);
            label6.appendChild(span6);
            div.appendChild(label6);

            backgrounds.appendChild(div);
            elem.appendChild(backgrounds);
        }

        {
            var aside = document.createElement("ASIDE");
            aside.className = "SumitButton";
            var div = document.createElement("DIV");
            div.className = "container";
            var butt = document.createElement("BUTTON");
            butt.type = "submit";
            butt.onmouseover = function () {
                this.style.backgroundColor = "orange"
            };
            butt.onmouseout = function () {
                this.style.backgroundColor = "#006680"
            };
            var strong = document.createElement("STRONG");
            strong.innerText = "Submit";
            var i = document.createElement("I");
            i.classList.add("fa");
            i.classList.add("fa-paper-plane");
            i.setAttribute("aria-hidden", "true");
            var span1 = document.createElement("SPAN");
            span1.className = "bar";
            var span2 = document.createElement("SPAN");
            span2.className = "load";

            span1.appendChild(span2);
            strong.appendChild(i);
            butt.appendChild(strong);
            butt.appendChild(span1);
            div.appendChild(butt);
            aside.appendChild(div);
            elem.appendChild(aside);
        }

        document.body.appendChild(elem);
    }

    getRangeVolume();
    getFirstName();
    getLastName();
    getCountry();
    getColor();
    getAge();
    getPersonages();
    getDificulty();
    getBackground();
    updateSubmitButton();

    seeInput();
}

function getRangeVolume() {

    var slider = document.getElementById("rangeVolume");
    var output = document.getElementById("volumeSpan");
    output.innerHTML = slider.value + "%";

    slider.oninput = function () {
        output.innerHTML = this.value + "%";
        volumeFromInput = this.value;
    };
}

function getFirstName() {

    var text = document.getElementById("fname");

    text.onblur = function () {
        firstNameFromInput = this.value;
        var numberOfLowerChar = this.value.match(/[a-z]/g);
        var numberOfUpperChar = this.value.match(/[A-Z]/g);
        numberOfLowerChar = numberOfLowerChar == null ? 0 : numberOfLowerChar.length;
        numberOfUpperChar = numberOfUpperChar == null ? 0 : numberOfUpperChar.length;
        if (this.value.length !== numberOfLowerChar + numberOfUpperChar)
            confirm("The name must be a character only!");
    };

    text.onkeyup = function () {
        var firstLetter = this.value.toString();
        if (firstLetter.length === 1) {
            firstLetter = firstLetter[0];
            this.value = firstLetter.toUpperCase();
        }
    };
}

function getLastName() {

    var text = document.getElementById("lname");

    text.onchange = function () {
        lastNameFromInput = this.value;
        var numberOfLowerChar = this.value.match(/[a-z]/g);
        var numberOfUpperChar = this.value.match(/[A-Z]/g);
        numberOfLowerChar = numberOfLowerChar == null ? 0 : numberOfLowerChar.length;
        numberOfUpperChar = numberOfUpperChar == null ? 0 : numberOfUpperChar.length;
        if (this.value.length !== numberOfLowerChar + numberOfUpperChar)
            confirm("The name must be a character only!");
    };

    text.onkeydown = function () {
        var firstLetter = this.value.toString();
        if (firstLetter.length === 1) {
            firstLetter = firstLetter[0];
            this.value = firstLetter.toUpperCase();
        }
    };
}

function getCountry() {

    var text = document.getElementById("country");

    text.oninput = function () {
        countryFromInput = this.value;
        if (this.value === "other") {
            var countryNew = prompt("Please enter your country", "Switzerland");
            countryFromInput = countryNew;
        }
    };
}

function getColor() {

    var selectMultiple = document.getElementById("colors");
    var options = selectMultiple && selectMultiple.options;

    selectMultiple.oninput = function () {
        for (var i = 0, iLen = options.length; i < iLen; i++) {

            if (options[i].selected) {
                colorsFromInput.push(options[i].value || options[i].text);
            }
        }
    };
    selectMultiple.onmouseenter = function () {
        this.style.opacity = "0.99";
    };
}

function getAge() {
    var text = document.getElementById("textareaAge");

    text.onmouseleave = function () {
        ageFromInput = this.value;
        var numberOfNumbers = this.value.match(/[0-9]/g);
        numberOfNumbers = numberOfNumbers == null ? 0 : numberOfNumbers.length;
        if (this.value.length !== numberOfNumbers)
            confirm("The age must be a number only!");
        if (ageFromInput === "")
            confirm("This field can not be empty!");
        else {
            if (ageFromInput <= 5)
                alert("You are too young!");
            if (ageFromInput >= 100)
                alert("You are too old!");
        }
    };

    text.onfocus = function () {
        this.style.opacity = "0.99";
    };
}

function getPersonages() {

    var label = document.getElementsByClassName("containerCheckBox");
    var checkBox = [];
    for (var i = 0, iLen = label.length; i < iLen; i++) {
        checkBox.push(label[i].getElementsByTagName("INPUT")[0]);
    }

    function removeFromPersonagesVector(number) {
        for (var i = 0; i < personagesFromInput.length; i++) {
            if (personagesFromInput[i] === number) {
                if (personagesFromInput.length - 1 === i)
                    personagesFromInput.pop();
                else {
                    personagesFromInput[i] = personagesFromInput[personagesFromInput.length - 1];
                    personagesFromInput.pop();
                }
                break;
            }
        }
    }

    checkBox[0].onchange = function () {
        if (checkBox[0].checked === true)
            personagesFromInput.push(0);
        else {
            if (verifyPersonages())
                removeFromPersonagesVector(0);
            else
                checkBox[0].checked = true;
        }
    };

    checkBox[1].onchange = function () {
        if (checkBox[1].checked === true)
            personagesFromInput.push(1);
        else {
            if (verifyPersonages())
                removeFromPersonagesVector(1);
            else
                checkBox[1].checked = true;
        }
    };

    checkBox[2].onchange = function () {
        if (checkBox[2].checked === true)
            personagesFromInput.push(2);
        else {
            if (verifyPersonages())
                removeFromPersonagesVector(2);
            else
                checkBox[2].checked = true;
        }
    };

    checkBox[3].onchange = function () {
        if (checkBox[3].checked === true)
            personagesFromInput.push(3);
        else {
            if (verifyPersonages())
                removeFromPersonagesVector(3);
            else
                checkBox[3].checked = true;
        }
    };

    checkBox[4].onchange = function () {
        if (checkBox[4].checked === true)
            personagesFromInput.push(4);
        else {
            if (verifyPersonages())
                removeFromPersonagesVector(4);
            else
                checkBox[4].checked = true;
        }
    };

    function verifyPersonages() {
        if (personagesFromInput.length === 1) {
            confirm("You must have at least a series of characters!");
            return false;
        }
        return true;
    }
}

function getDificulty() {

    var datalistInput = document.getElementsByName("dificulty")[0];

    datalistInput.onmouseleave = function () {
        for (var i = 0; i < document.getElementById('dificulty').options.length; i++) {
            if (document.getElementById('dificulty').options[i].value === document.getElementsByName("dificulty")[0].value) {
                var id = document.getElementById('dificulty').options[i].getAttribute('value');
                break;
            }
        }
        if (datalistInput.value === "")
            confirm("This field can not be empty!");
        difucultyFromInput = id;
    };
    datalistInput.onkeypress = function () {
        var firstLetter = this.value.toString();
        if (firstLetter.length === 1) {
            firstLetter = firstLetter[0];
            this.value = firstLetter.toUpperCase();
        }
    };
}

function getBackground() {
    var radio = document.getElementsByName("radio");

    for (var i = 0; i < radio.length; i++) {
        if (radio[i].checked) {
            backgroundFromInput = i;
            break;
        }
    }
}

function updateSubmitButton() {
    var lBar = $(".load");
    var bar = $("button span");
    var button = $("button");

    button.on("click", function () {
        lBar.addClass("loading");

        getRangeVolume();
        getFirstName();
        getLastName();
        getCountry();
        getColor();
        getAge();
        getPersonages();
        getDificulty();
        getBackground();

        seeInput();

        setTimeout(function () {
            if (verify()) {
                button.addClass("completeSubmit");
                InputOk = true;
            }
            else
                lBar.addClass("load");
            lBar.removeClass("loading");
        }, 500);
    });
}

function verify() {
    var options = document.getElementsByClassName("options")[0];
    if (ageFromInput == undefined && options.style.display != "none") {
        confirm("Please complete the age section!");
        return false;
    }
    if (difucultyFromInput == undefined && options.style.display != "none") {
        confirm("Please complete the dificulty section!");
        return false;
    }
    return true;
}

function seeInput() {
    console.log(volumeFromInput);
    console.log(firstNameFromInput);
    console.log(lastNameFromInput);
    console.log(countryFromInput);
    console.log(colorsFromInput);
    console.log(ageFromInput);
    console.log(personagesFromInput);
    console.log(difucultyFromInput);
    console.log(backgroundFromInput);
}

function exit() {
    window.close();
}

function getRndInteger(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function setBackground() {
    var bg = document.getElementById("backgroundGame");
    bg.style.backgroundImage = 'url(' + backgroundsSrc[backgroundFromInput] + ')';
    bg.style.display = "block";
}

function setMovies() {
    var random = getRndInteger(0, moviesWallpaper.length - 1);
    var tv = document.getElementById("tv");
    tv.style.backgroundImage = 'url(' + moviesWallpaper[random] + ')';
    currentMovie = random;
    return random;
}

var setBulletAtomic = null;

function setAllies() {

    document.getElementById("tv").addEventListener("click", function () {
        if (level - 1 === currentMovie) {
            var bg = document.getElementById("backgroundGame");
            bg.appendChild(allies[level - 1]);
            var inMove = true;
            bg.onmousemove = function (ev) {
                if (inMove) {
                    allies[level - 1].style.left = ev.pageX - parseInt(allies[level - 1].style.width) / 2 + 'px';
                    allies[level - 1].style.top = ev.pageY - HEIGHT_CHARACTER / 2 + 'px';
                }
            };
            bg.ondblclick = function (ev) {
                if (inMove) {
                    allies[level - 1].style.left = ev.pageX - parseInt(allies[level - 1].style.width) / 2 + 'px';
                    allies[level - 1].style.top = 65 + '%';
                    bg.appendChild(allies[level - 1]);
                    inMove = false;

                    setBulletAtomic = setInterval(function () {

                        var allayLife = allies[level - 1].getElementsByClassName("progressLife")[0];
                        allayLife.style.width = parseInt(getComputedStyle(allayLife).width) - .5 + 'px';
                        if (parseInt(getComputedStyle(allayLife).width) < .5) {
                            allies[level - 1].getElementsByClassName("progressLife")[0].style.width = 100 + '%';
                            document.getElementById("backgroundGame").removeChild(allies[level - 1]);
                            clearInterval(setBulletAtomic);
                        }

                        var bulletAtomic = document.createElement("div");
                        bulletAtomic.classList.add("bullet");
                        bulletAtomic.classList.add("atomic");
                        bulletAtomic.style.left = parseInt(allies[level - 1].style.left) + 50 + 'px';
                        bg.appendChild(bulletAtomic);
                        setInterval(function () {
                            if (parseInt(getComputedStyle(bulletAtomic).left) +
                                Math.sqrt(Math.pow(parseInt(getComputedStyle(bulletAtomic).width), 2) +
                                    Math.pow(parseInt(getComputedStyle(bulletAtomic).height), 2)) < window.innerWidth - 1)
                                bulletAtomic.style.left = parseInt(getComputedStyle(bulletAtomic).left) + 1 + 'px';
                        }, 10)
                    }, 1000);
                }
            };
        }

    }, false);
}

function setEnamy() {

    var bg = document.getElementById("backgroundGame");
    bg.appendChild(enemies[level - 1]);
    enemies[level - 1].style.left = window.innerWidth - parseInt(enemies[level - 1].style.width) - 25 + 'px';
    enemies[level - 1].style.top = 65 + '%';
    var interval = setInterval(function () {

        enemies[level - 1].style.left = parseInt(enemies[level - 1].style.left) - 1 + 'px';
    }, 100);
}

var keyPress = null;

function setProtagonist() {

    var bg = document.getElementById("backgroundGame");
    player.style.top = 65 + '%';
    player.style.left = 65 + 'px';
    bg.appendChild(player);

    var interval = setInterval(function () {
        var speedY = 0;
        if (keyPress && keyPress === 37 && parseInt(player.style.left) > 0) {
            speedY = -1;
        }
        if (keyPress && keyPress === 39 && parseInt(player.style.left) < window.innerWidth - parseInt(player.style.width) - 1) {
            speedY = 1;
        }
        player.style.left = parseInt(player.style.left) + speedY + 'px';

    }, 1);
    window.addEventListener('keydown', function (ev) {
        keyPress = ev.keyCode;
    });
    window.addEventListener('keyup', function (ev) {
        keyPress = false;
    });
    window.addEventListener('keydown', function (ev) {
        if (ev.keyCode === 32) {
            var playerlife = player.getElementsByClassName("progressLife")[0];
            playerlife.style.width = parseInt(getComputedStyle(playerlife).width) - .5 + 'px';
            if (parseInt(getComputedStyle(playerlife).width) < .5) {
                saveInLocalStorage();
                sounds[0].play();
                alert("Game Over");
                player.getElementsByClassName("progressLife")[0].style.width = 100 + '%';
                document.getElementById("backgroundGame").removeChild(player);
                document.getElementById("backgroundGame").removeChild(enemies[level - 1]);
                exitToMenu();
            }

            var bulletLightning = document.createElement("div");
            bulletLightning.classList.add("bullet");
            bulletLightning.classList.add("lightning");
            bulletLightning.style.left = parseInt(player.style.left) + 50 + 'px';
            bg.appendChild(bulletLightning);
            setInterval(function () {
                if (parseInt(getComputedStyle(bulletLightning).left) + parseInt(getComputedStyle(bulletLightning).height)
                    < window.innerWidth - 1)
                    bulletLightning.style.left = parseInt(getComputedStyle(bulletLightning).left) + 1 + 'px';
            }, 10)
        }
    })
}

function collisionTest(elem1, elem2) {
    var CSS1 = getComputedStyle(elem1);
    var CSS2 = getComputedStyle(elem2);
    return parseInt(CSS1.left) < parseInt(CSS2.left) + parseInt(CSS2.width) &&
        parseInt(CSS1.left) + parseInt(CSS1.width) > parseInt(CSS2.left) &&
        parseInt(CSS1.top) < parseInt(CSS2.top) + parseInt(CSS2.height) &&
        parseInt(CSS1.top) + parseInt(CSS1.height) > parseInt(CSS2.top);
}

function game() {
    if (InputOk === true) {
        hiddenMenuScreen();
        setMenuButton();
        unsetLogo();
        setBackground();
        document.getElementById("backgroundGame").appendChild(sounds[0].HTML);
        score = document.getElementById("scoreValue")
        newGame();
    } else {
        confirm("Please complete the options first!");
    }
}

function newGame() {

    setAllies();
    setProtagonist();
    setEnamy();

    setInterval(function () {
        setMovies()
    }, 5000);

    setInterval(function () {
        gameUpdate()
    }, 50);

    //seeCharacters()
}

function gameUpdate() {

    if (collisionTest(player, enemies[level - 1])) {

        var elem = player.getElementsByClassName("progressLife")[0];
        elem.style.width = parseInt(getComputedStyle(elem).width) - .01 + 'px';
        enemies[level - 1].style.left = parseInt(enemies[level - 1].style.left) + 2 + 'px';
        if (parseInt(getComputedStyle(elem).width) < .01) {
            document.getElementById("backgroundGame").appendChild(sounds[0].HTML);
            sounds[0].play();

            player.getElementsByClassName("progressLife")[0].style.width = 100 + '%';
            document.getElementById("backgroundGame").removeChild(player);
            document.getElementById("backgroundGame").removeChild(enemies[level - 1]);
            saveInLocalStorage();
            alert("Game Over");
            exitToMenu();
        }
    }

    if (collisionTest(enemies[level - 1], allies[level - 1])) {
        var elem = allies[level - 1].getElementsByClassName("progressLife")[0];
        elem.style.width = parseInt(getComputedStyle(elem).width) - .02 + 'px';
        enemies[level - 1].style.left = parseInt(enemies[level - 1].style.left) + 2 + 'px';
        if (parseInt(getComputedStyle(elem).width) < .02) {
            document.getElementById("backgroundGame").removeChild(allies[level - 1]);
            allies[level - 1].getElementsByClassName("progressLife")[0].style.width = 100 + '%';
            clearInterval(setBulletAtomic);
        }
    }

    var lightnings = document.getElementsByClassName("lightning");
    for (var i = 0; i < lightnings.length; i++) {
        if (collisionTest(enemies[level - 1], lightnings[i])) {
            var elem = enemies[level - 1].getElementsByClassName("progressLife")[0];
            elem.style.width = parseInt(getComputedStyle(elem).width) - 2.5 + 'px';
            enemies[level - 1].style.left = parseInt(enemies[level - 1].style.left) + 2.5 + 'px';
            score.innerText = (parseInt(score.innerText) + 10).toString();
            if (parseInt(getComputedStyle(elem).width) < 2.5) {
                document.getElementById("backgroundGame").removeChild(enemies[level - 1]);
                enemies[level - 1].getElementsByClassName("progressLife")[0].style.width = 100 + '%';
                nextLevel();
            }
            document.getElementById("backgroundGame").removeChild(lightnings[i]);
        }
    }

    var atomics = document.getElementsByClassName("atomic");
    for (var i = 0; i < atomics.length; i++) {
        if (collisionTest(enemies[level - 1], atomics[i])) {
            var elem = enemies[level - 1].getElementsByClassName("progressLife")[0];
            elem.style.width = parseInt(getComputedStyle(elem).width) - 2.5 + 'px';
            enemies[level - 1].style.left = parseInt(enemies[level - 1].style.left) + 2.5 + 'px';
            score.innerText = (parseInt(score.innerText) + 5).toString();
            if (parseInt(getComputedStyle(elem).width) < 2.5) {
                document.getElementById("backgroundGame").removeChild(enemies[level - 1]);
                enemies[level - 1].getElementsByClassName("progressLife")[0].style.width = 100 + '%';
                nextLevel();
            }
            document.getElementById("backgroundGame").removeChild(atomics[i]);
        }
    }
}

function nextLevel() {

    score.innerText = (parseInt(score.innerText) + 100 * level).toString();
    var bg = document.getElementById("backgroundGame");
    var allay = document.getElementsByClassName("ally");
    if (allay.length !== 0) {
        bg.removeChild(allies[level - 1]);
        clearInterval(setBulletAtomic);
    }
    level++;
    sounds[1].play();

    if (level === 6) {
        saveInLocalStorage();
        alert("You win !!! :)");
    }

    newGame();
}

function saveInLocalStorage() {
    console.log("LS")
    if (typeof(Storage) !== "undefined") {
        var heighscore = null;
        var date = new Date();
        if (heighscore = localStorage.getItem("heighscore")) {
            if (heighscore <= parseInt(score.innerText)) {
                localStorage.setItem("heighscore", score.innerText);
                localStorage.setItem("heighscoreDate", date.toDateString());
            }
        } else {
            localStorage.setItem("heighscore", score.innerText);
            localStorage.setItem("heighscoreDate", date.toDateString());
        }
    } else {
        console.log("Sorry, your browser does not support web storage...");
    }
}
