console.log("run gitweb.js");

function htmlToElement(html) {
    var template = document.createElement('template');
    html = html.trim(); // Never return a text node of whitespace as the result
    template.innerHTML = html;
    return template.content.firstChild;
}

// Title, Subtitle
var pathHeader = document.getElementById("original_gitweb")
                    .getElementsByClassName("page_header")[0];
                    console.log(pathHeader.childNodes)
document.getElementById("currentTitle").appendChild(pathHeader.getElementsByTagName("a")[pathHeader.getElementsByTagName("a").length-1].cloneNode(true));
document.getElementById("currentSubTitle").innerHTML = pathHeader.childNodes[pathHeader.childNodes.length-1].textContent
                                                                    .replace("/","")
                                                                    .replace(" ","");


// bouton home
document.getElementById("homelink").href = document.getElementById("original_gitweb")
                                                   .getElementsByClassName("page_header")[0]
                                                   .getElementsByTagName("a")[1].href;

// menu footer
var templateMenuFooter=`
    <li class="mdl-list__item mdl-menu__item">
    <a href="specHref">
        <span class="mdl-list__item-primary-content">
            <i class="material-icons mdl-list__item-icon">specIcon</i>
            specLib
        </span>
    </a>
    </li>`

var listOfItems = document.getElementById("original_gitweb")
                          .getElementsByClassName("page_footer")[0]
                          .getElementsByTagName("a");
for (var i = 0; i < listOfItems.length; ++i) {
    document.getElementById("footermenu").appendChild(
        htmlToElement(
            templateMenuFooter.replace("specHref",listOfItems[i].href)
                              .replace("specLib",listOfItems[i].textContent)
                              .replace("specIcon", (listOfItems[i].classList.contains('rss_logo')) ? "rss_feed" : "bookmark")
        )
    );
    
}


