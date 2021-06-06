/*___________________________ HTTP://BONARJA.COM ___________________________*/
function SLIDEPAGE(options) {
    var self = this;
    var priv = {};
    this.el;
    this.pages = [];
    this.active = null;
    this.direction = "x";
    this.transition = 250;
    this.display = "block";
    this.inAnimation = false;
    this.realNumber = false;
    this.repeat = false;
    this.forceDirection = true;
    priv.loadCSS = function() {
        self.el.classList.add("sp_sp");
        if (!document.querySelector("#sp_css")) {
            var sp_css = document.createElement("style");
            sp_css.id = "fp_css";
            sp_css.innerHTML = `
                .sp_sp {
                    position: relative;
                    overflow: hidden;
                }
                .sp_sp .sp_page {
                    width: 100%;
                    height: 100%;
                    position: absolute;
                    left: 0;
                    top: 0;
                    transition: all ${self.transition}ms ease;
                    display: none;
                }
                .sp_sp .sp_page.sp_active {
                    display: block;
                }
            `;
            document.querySelector("head").appendChild(sp_css);
        }
        self.pages[0].classList.add("sp_active");
        self.active = 0;
    };
    priv.show = function(el, nextOrPrev) {
        Object.assign(el.style, {
            display: self.display,
            [self.direction]: nextOrPrev === "next" ? "100%" : "-100%"
        });
        setTimeout(function() {
            el.style[self.direction] = 0;
        }, 10);
    };
    priv.hide = function(el, nextOrPrev) {
        return new Promise(function(done) {
            el.style[self.direction] = nextOrPrev === "next" ? "-100%" : "100%";
            setTimeout(function() {
                el.style.display = "none";
                done();
            }, self.transition + 20);
        });
    };
    priv.animation = function(forShow, forHide, nextOrPrev) {
        return new Promise(function(done) {
            priv.show(forShow, nextOrPrev);
            priv.hide(forHide, nextOrPrev).then(function() {
                done();
            });
        });
    };
    this.go = function(n, forceDirection) {
        return new Promise(function(done) {
            if (self.realNumber) {
                n = n - 1;
            }
            if (
                n === self.active ||
                n >= self.pages.length ||
                self.inAnimation ||
                n < 0
            )
                return;
            self.inAnimation = true;
            var forShow = self.pages[n];
            var forHide = self.pages[self.active];
            priv.animation(
                forShow,
                forHide,
                self.forceDirection && forceDirection
                    ? forceDirection
                    : n > self.active
                    ? "next"
                    : "prev"
            ).then(function() {
                self.active = n;
                self.inAnimation = false;
                done({ current: forShow, previous: forHide });
            });
        });
    };
    this.next = function() {
        return new Promise(function(done) {
            var n = self.active + 1;
            var limit = self.pages.length;
            if (self.realNumber) {
                limit++;
                n++;
            }
            if (n >= limit) {
                if (self.repeat) {
                    n = self.realNumber ? 1 : 0;
                } else {
                    return done();
                }
            }
            self.go(n, "next").then(function(data) {
                done(data);
            });
        });
    };
    this.prev = function() {
        return new Promise(function(done) {
            var n = self.active - 1;
            if (self.realNumber) {
                n++;
            }
            if (n < self.realNumber ? 1 : 0) {
                if (self.repeat) {
                    n = self.realNumber
                        ? self.pages.length
                        : self.pages.length - 1;
                } else {
                    return done();
                }
            }
            self.go(n, "prev").then(function(data) {
                done(data);
            });
        });
    };
    this.show = function(n) {
        if (self.realNumber) {
            n = n - 1;
        }
        if (
            n === self.active ||
            n >= self.pages.length ||
            self.inAnimation ||
            n < 0
        )
            return;
        var forHide = self.pages[self.active];
        forHide.style.display = "none";
        var forShow = self.pages[n];
        Object.assign(forShow.style, {
            display: "block",
            [self.direction]: 0
        });
        self.active = n;
        return {
            current: forShow,
            previous: forHide
        };
    };
    (function constructor() {
        if (typeof options.el === "string") {
            self.el = document.querySelector(options.el);
        } else {
            self.el = options.el;
        }
        if (options.pages) {
            self.pages = self.el.querySelectorAll(options.pages);
            self.pages.forEach(x => x.classList.add(".sp_page"));
        } else {
            self.pages = self.el.querySelectorAll(".sp_page");
        }
        if (options.direction) {
            if (options.direction !== "x" && options.direction !== "y") return;
            self.direction = options.direction;
        }
        if (options.transition && typeof options.transition === "number") {
            self.transition = options.transition;
        }
        if (options.display) {
            self.display = options.display;
        }
        if (options.realNumber) {
            self.realNumber = true;
        }
        if (options.repeat) {
            self.repeat = true;
        }
        if (typeof options.forceDirection === "boolean") {
            self.forceDirection = options.forceDirection;
        }
        if (self.direction === "x") {
            self.direction = "left";
        } else {
            self.direction = "top";
        }

        priv.loadCSS();
    })();
}
export { SLIDEPAGE };
