(function() {
  var Game, Mode, main,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Game = (function() {

    function Game() {
      this.update = __bind(this.update, this);      this.window = window;
      this.animFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || null;
    }

    Game.prototype.tick = function(dothis) {
      return this.animFrame.call(this.window, dothis);
    };

    Game.prototype.update = function() {
      this.tick(this.update);
      return console.log("update");
    };

    Game.prototype.start = function() {
      this.tick(this.update);
      return console.log("started");
    };

    return Game;

  })();

  Mode = (function() {

    function Mode(window) {
      this.window = window;
    }

    Mode.prototype.update = function() {
      return console.log("Mode update");
    };

    return Mode;

  })();

  main = new Game;

  main.start();

}).call(this);
