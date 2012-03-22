(function() {
  var Game, Intro, Level, main,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Game = (function() {

    function Game() {
      this.update = __bind(this.update, this);
      this.tick = __bind(this.tick, this);      this.t1 = this.t2 = Date.now();
      this.dt = 0;
      this.window = window;
      this.animFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || null;
    }

    Game.prototype.tick = function() {
      this.t2 = Date.now();
      this.dt = this.t2 - this.t1;
      this.t1 = this.t2;
      this.update();
      return this.animFrame.call(this.window, this.tick);
    };

    Game.prototype.update = function() {
      return this.mode.update(this.dt);
    };

    Game.prototype.start = function(level, canvas_id) {
      this.mode = new level(this.window, canvas_id);
      this.tick();
      return console.log("started");
    };

    return Game;

  })();

  Level = (function() {

    function Level(window, canvas_id) {
      this.window = window;
      this.canvas = document.getElementById(canvas_id);
      this.ctx = this.initcanvas();
      this.setup;
    }

    Level.prototype.initcanvas = function() {
      return this.canvas.getContext('2d');
    };

    Level.prototype.setup = function() {
      return console.log("set up");
    };

    Level.prototype.update = function(dt) {
      return console.log("Mode update" + dt);
    };

    return Level;

  })();

  Intro = (function(_super) {

    __extends(Intro, _super);

    function Intro() {
      Intro.__super__.constructor.apply(this, arguments);
    }

    Intro.prototype.setup = function() {
      return console.log("Intro set up");
    };

    Intro.prototype.update = function(dt) {
      this.fps = Math.round(1000 / dt);
      console.log(this.fps);
      this.ctx.save();
      this.ctx.fillStyle = "rgb(200, 200, 200)";
      this.ctx.font = "Bold 20px Monospace";
      this.ctx.fillText("" + this.fps + " FPS", 10, 20);
      return this.ctx.restore();
    };

    return Intro;

  })(Level);

  main = new Game;

  main.start(Intro, 'game');

}).call(this);
