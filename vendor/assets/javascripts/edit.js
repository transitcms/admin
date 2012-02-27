//= require ./spine

(function() {
  var Edit, Toolbar, applyFormat, commandActive, update_states,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  commandActive = function(cmd) {
    try {
      return document.queryCommandState(cmd, false, true);
    } catch (erorr) {
      return false;
    }
  };

  applyFormat = function(instance, format) {
    if (commandActive(format)) {
      instance.removeFormat();
    } else {
      document.execCommand(format, false, true);
    }
    return update_states(instance, format);
  };

  update_states = function(instance, format) {
    if (instance.toolbar) {
      return instance.toolbar.trigger('update', format, commandActive(format));
    }
  };

  if (typeof Spine === "undefined" || Spine === null) Spine = require('spine');

  Edit = (function(_super) {

    __extends(Edit, _super);

    Edit.options = {
      multiline: true,
      markup: true
    };

    Edit.toolbar = null;

    function Edit() {
      Edit.__super__.constructor.apply(this, arguments);
      this.el.attr("contenteditable", true).css({
        outline: 'none'
      });
      if (this.options) {
        jQuery.extend({}, this.options, Edit.options);
        if (this.options.toolbar) {
          this.toolbar = new Toolbar({
            instance: this,
            el: $(this.options.toolbar)
          });
        }
      }
    }

    Edit.prototype.changed = false;

    Edit.prototype.pending = false;

    Edit.prototype.contents = false;

    Edit.prototype.bold = function() {
      return applyFormat(this, 'bold');
    };

    Edit.prototype.exec = function(command) {
      return document.execCommand(command, false, true);
    };

    Edit.prototype.italic = function() {
      return applyFormat(this, 'italic');
    };

    Edit.prototype.indent = function() {
      if (commandActive('insertOrderedList') || commandActive('insertUnorderedList')) {
        return this.exec('indent');
      }
    };

    Edit.prototype.image = function(href) {
      this.removeFormat;
      if (typeof href === 'undefined') href = window.prompt('URL:', 'http://');
      if (href !== "") return document.execCommand('insertImage', false, href);
    };

    Edit.prototype.link = function(href) {
      var emptyexp, usersel;
      usersel = this.select();
      emptyexp = new RegExp(/^\s*$/);
      if (typeof href === 'undefined') href = prompt("URL:", "http://");
      if (emptyexp.test(href) !== true) {
        document.execCommand('createLink', false, href);
      } else {
        this.unlink();
      }
      return this.instance;
    };

    Edit.prototype.ol = function() {
      this.exec('insertOrderedList');
      return update_states(this, 'insertOrderedList');
    };

    Edit.prototype.ul = function() {
      this.exec('insertUnorderedList');
      return update_states(this, 'insertUnorderedList');
    };

    Edit.prototype.unlink = function() {
      return this.exec('unlink');
    };

    Edit.prototype.outdent = function() {
      if (commandActive('insertOrderedList') || commandActive('insertUnorderedList')) {
        return this.exec('outdent');
      }
    };

    Edit.prototype.removeFormat = function() {
      var instance;
      instance = this;
      document.execCommand('removeFormat', false, true);
      return instance;
    };

    Edit.prototype.undo = function() {
      return this.exec('undo');
    };

    Edit.prototype.selection = null;

    Edit.prototype.select = function(range) {
      var usersel;
      if (range && range !== null) {
        if (window.getSelection) {
          usersel = window.getSelection();
          usersel.removeAllRanges();
          return this.selection = usersel.addRange(range);
        } else if (document.selection && range.select) {
          return this.selection = range.select;
        }
      } else {
        if (window.getSelection) {
          usersel = window.getSelection();
          if (usersel.rangeCount > 0) {
            this.selection = usersel.getRangeAt(0);
          } else if (document.selection && document.selection.createRange) {
            this.selection = document.selection.createRange();
          } else {
            this.selection = null;
          }
          return this.selection;
        }
      }
    };

    Edit.prototype.selectAll = function() {
      var range;
      range = document.createRange();
      range.selectNodeContents(this.el.get(0));
      return this.select(range);
    };

    Edit.prototype.applyCallback = function(callback) {
      var container, in_dom, usersel;
      usersel = this.select();
      container = {};
      if (usersel && usersel !== null) {
        container.start = usersel.startContainer;
        container.startOffset = usersel.startOffset;
        container.end = usersel.endContainer;
        container.endOffset = usersel.endOffset;
      }
      callback(usersel);
      if (usersel && usersel !== null) {
        in_dom = function(node) {
          if (node === document.body) return true;
          if (node.parentNode) return in_dom(node.parentNode);
          return false;
        };
        if (in_dom(container.start)) {
          usersel.setStart(container.start, container.startOffset);
        }
        if (in_dom(container.end)) {
          usersel.setEnd(container.end, container.endOffset);
        }
      }
      return this.select(usersel);
    };

    Edit.prototype.semantify = function() {
      var node, replace;
      node = this.el;
      replace = function(old, real) {
        return node.find(old).each(function() {
          var curr;
          curr = jQuery(this);
          return curr.replaceWith(jQuery(document.createElement(real)).html(curr.html()));
        });
      };
      replace('i', 'em');
      replace('b', 'strong');
      replace('div', 'p');
      node.find('span').each(function() {
        if (this.firstChild) return jQuery(this.firstChild).unwrap();
      });
      node.find('p, ol, ul').each(function() {
        var curr, _results;
        curr = $(this);
        _results = [];
        while (curr.parent().is("p")) {
          _results.push(curr.unwrap());
        }
        return _results;
      });
      node.find('ul > ul, ul > ol, ol > ul, ol > ol').each(function() {
        var curr;
        curr = jQuery(this);
        if (curr.prev()) {
          return curr.prev().append(this);
        } else {
          return curr.wrap($('<li />'));
        }
      });
      (function() {
        var child, children, clone, paragraph, wrap_paragraph, _i, _len, _results;
        paragraph = [];
        wrap_paragraph = function() {
          var makes, p, _i, _len;
          if (paragraph.length) {
            makes = jQuery('<p />').insertBefore(paragraph[0]);
            for (_i = 0, _len = paragraph.length; _i < _len; _i++) {
              p = paragraph[_i];
              jQuery(p).remove().appendTo(makes);
            }
          }
          return paragraph = [];
        };
        clone = function(object) {
          if (jQuery.type(object) === 'array') {
            return object.slice();
          } else {
            return jQuery.extend({}, object);
          }
        };
        children = clone(node.get(0).childNodes);
        _results = [];
        for (_i = 0, _len = children.length; _i < _len; _i++) {
          child = children[_i];
          if (!jQuery(child).is('p, ul, ol') && !(child.nodeType === Node.TEXT_NODE && /^\s*$/.exec(child.data))) {
            _results.push(paragraph.push(child));
          } else {
            _results.push(wrap_paragraph());
          }
        }
        return _results;
      })();
      node.find('br').each(function() {
        if (this.parentNode.lastChild === this) return jQuery(this).remove();
      });
      return node.find('span').each(function() {
        return jQuery(this).children().first().unwrap();
      });
    };

    Edit.stripTags = function(input, allowed) {
      var commentsAndPhpTags, html_tags;
      allowed = (((allowed || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join('');
      html_tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi;
      commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
      return input.replace(commentsAndPhpTags, '').replace(html_tags, function() {
        var _ref;
        return (_ref = allowed.indexOf('<' + $1.toLowerCase() + '>') > -1) != null ? _ref : {
          $0: ''
        };
      });
    };

    return Edit;

  })(Spine.Controller);

  Toolbar = (function(_super) {

    __extends(Toolbar, _super);

    Toolbar.prototype.events = {
      'click a[data-command]': 'run'
    };

    function Toolbar(options) {
      Toolbar.__super__.constructor.apply(this, arguments);
    }

    Toolbar.prototype.run = function(event) {
      var command;
      event.preventDefault;
      command = jQuery(event.currentTarget).attr('data-command');
      if (command && this.instance[command]) {
        return this.instance[command].apply(this.instance);
      }
    };

    return Toolbar;

  })(Spine.Controller);

  this.Spine.Edit = this.Edit = Edit;

}).call(this);