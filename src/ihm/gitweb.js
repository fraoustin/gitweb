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
document.getElementById("currentTitle").appendChild(pathHeader.getElementsByTagName("a")[pathHeader.getElementsByTagName("a").length-1].cloneNode(true));
document.getElementById("currentSubTitle").innerHTML = pathHeader.childNodes[pathHeader.childNodes.length-1].textContent
                                                                    .replace("/","")
                                                                    .replace(" ","");


// bouton home and homelink
document.getElementById("homelink").href = document.getElementById("original_gitweb")
                                                   .getElementsByClassName("page_header")[0]
                                                   .getElementsByTagName("a")[1].href;
document.getElementById("homebtn").href = document.getElementById("original_gitweb")
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

// menu navigation
var templateMenuNav=`
<li class="mdl-list__item mdl-navigation__link">
<a href="specHref">
    <span class="mdl-list__item-primary-content">
        <i class="material-icons mdl-list__item-icon">specIcon</i>
        specLib
    </span>
</a>
</li>`

if (document.getElementById("original_gitweb").getElementsByClassName("page_nav").length > 0){
    var listOfItems = document.getElementById("original_gitweb")
                        .getElementsByClassName("page_nav")[0]
                        .getElementsByTagName("a");
    var firstMenu = true;
    for (var i = 0; i < listOfItems.length; ++i) {
        if (firstMenu && !!listOfItems[i].previousElementSibling && listOfItems[i].previousElementSibling.tagName == "br") {
            firstMenu = false;
        }
        if (firstMenu) {
            document.getElementById("menuNav").appendChild(
                htmlToElement(
                    templateMenuNav.replace("specHref",listOfItems[i].href)
                                    .replace("specLib",listOfItems[i].textContent)
                                    .replace("specIcon", "home")
                )
            );        
        }
    }
    var listOfItems = document.getElementById("original_gitweb")
        .getElementsByClassName("page_nav")[0].getElementsByTagName("br");
    elt = listOfItems[0].nextSibling;
    while (elt) {
        var eltnext = elt.nextSibling;
        document.getElementById("submenu").appendChild(elt);
        elt = eltnext;
    }
}


// manage project_list
var templateProjectList=`
<div class="headerElt">
<ul class="mdl-list">
specList
</ul>
</div>`
var templateProjectItem=`
<li class="mdl-list__item mdl-list__item--two-line">
<span class="mdl-list__item-primary-content">
  <i class="material-icons mdl-list__item-avatar">place</i>
  <span>specTitle</span>
  <span class="mdl-list__item-sub-title">specSubTitle1</span>
  <span class="mdl-list__item-sub-title">specSubTitle2</span>
</span>
</li>`


var listOfItems = document.getElementById("original_gitweb")
                      .getElementsByClassName("project_list");

for (var i = 0; i < listOfItems.length; ++i) {
    var listOfSubItems = listOfItems[i].getElementsByTagName("tr");
    var specList = ""
    for (var j = 1; j < listOfSubItems.length; ++j) {
        specList = specList + htmlToElement(
            templateProjectItem.replace("specTitle",listOfSubItems[j].getElementsByTagName("td")[0].outerHTML)
                    .replace("specSubTitle1",listOfSubItems[j].getElementsByTagName("td")[1].outerHTML)
                    .replace("specSubTitle2",listOfSubItems[j].getElementsByTagName("td")[3].outerHTML)
        ).outerHTML
    }
    document.getElementById("content_gitweb").appendChild(
        htmlToElement(
            templateProjectList.replace("specList",specList)
        )
    )
}



// manage projects_list
var templateProjectsList=`
<div class="headerElt">
<ul class="mdl-list">
specList
</ul>
</div>`
var templateProjectsItem=`
<li class="mdl-list__item">
<span class="mdl-list__item-primary-content">
specLib
</span>
</li>`


var listOfItems = document.getElementById("original_gitweb")
                      .getElementsByClassName("projects_list");

for (var i = 0; i < listOfItems.length; ++i) {
    var listOfSubItems = listOfItems[i].getElementsByTagName("tr");
    var specList = ""
    for (var j = 0; j < listOfSubItems.length; ++j) {
        specList = specList + htmlToElement(
            templateProjectsItem.replace("specLib",listOfSubItems[j].getElementsByTagName("td")[1].outerHTML)
        ).outerHTML
    }
    document.getElementById("content_gitweb").appendChild(
        htmlToElement(
            templateProjectsList.replace("specList",specList)
        )
    )
}

// manage header
var templateHeader=`
<div class="headerElt">
<h5 class="mdl-color-text--primary">specLib</h5>
</div>`

var listOfItems = document.getElementById("original_gitweb").querySelectorAll(':scope > .header');

for (var i = 0; i < listOfItems.length; ++i) {
    var item = htmlToElement(
        templateHeader.replace("specLib",listOfItems[i].getElementsByTagName("a")[0].outerHTML)
    )
    var elt = listOfItems[i].nextElementSibling;
    while (elt && elt.nodeName in{"div":"","table":""} && !(elt.classList.contains("header")) && !(elt.classList.contains("page_footer"))) {
        var eltnext = elt.nextElementSibling;
        item.appendChild(elt);
        elt = eltnext;
    }   
    document.getElementById("content_gitweb").appendChild(item);
}


var listOfTags = document.getElementsByClassName("tag");
for (var i = 0; i < listOfTags.length; ++i) {
    listOfTags[i].className += " mdl-color-text--accent";
};
var listOfTags = document.getElementsByClassName("refs");
for (var i = 0; i < listOfTags.length; ++i) {
    listOfTags[i].className += " mdl-color-text--primary-dark";
};

