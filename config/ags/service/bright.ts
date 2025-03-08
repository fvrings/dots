class BrightnessService extends Service {
  // every subclass of GObject.Object has to register itself
  static {
    // takes three arguments
    // the class itself
    // an object defining the signals
    // an object defining its properties
    Service.register(
      this,
      {
        // 'name-of-signal': [type as a string from GObject.TYPE_<type>],
        "screen-changed": ["float"],
      },
      {
        // 'kebab-cased-name': [type as a string from GObject.TYPE_<type>, 'r' | 'w' | 'rw']
        // 'r' means readable
        // 'w' means writable
        // guess what 'rw' means
        "screen-value": ["float", "rw"],
      },
    );
  }

  // # prefix means private in JS
  #screenValue = 0;
  #max = 100;

  // the getter has to be in snake_case
  get screen_value() {
    return this.#screenValue;
  }

  // the setter has to be in snake_case too
  set screen_value(percent) {
    if (percent > 100) {
      percent = 100;
    }
    Utils.exec(`sudo ddcutil setvcp 10 ${percent}`);
    this.#screenValue = percent;
    this.notify("screen-value"); // emits "notify::screen-value"
  }

  constructor() {
    super();

    // initialize
    this.#onChange();
  }

  #onChange() {
    this.#screenValue = Number(
      Utils.exec(
        `nu -c "sudo ddcutil getvcp 10 |split column --regex '\\s+'|get column9.0 |str substring 0..1"`,
      ),
    );

    // signals have to be explicitly emitted
    this.emit("changed"); // emits "changed"
    this.notify("screen-value"); // emits "notify::screen-value"

    // or use Service.changed(propName: string) which does the above two
    // this.changed('screen-value');

    // emit screen-changed with the percent as a parameter
    this.emit("screen-changed", this.#screenValue);
  }

  // overwriting the connect method, let's you
  // change the default event that widgets connect to
  connect(event = "screen-changed", callback) {
    return super.connect(event, callback);
  }
}

// the singleton instance
const service = new BrightnessService();

// export to use in other modules
export default service;
