# Neditor Plugin API

Neditor is extensible! You can write plugins in Nitpick that interact with the editor, modify text, and intercept keyboard inputs. 

## The `Plugin` Struct
To write a plugin, you'll need to define functions matching the plugin hooks and populate a `Plugin` struct.

```nitpick
use "core/plugin.npk".*;

pub struct:Plugin = {
    string:name;
    string:version;
    int64:on_load;      // Hook: func(EditorContext:ctx) -> EditorContext
    int64:on_unload;    // Hook: func(EditorContext:ctx) -> EditorContext
    int64:on_key_press; // Hook: func(EditorContext:ctx, int32:vk) -> EditorContext
};
```

Because Nitpick does not currently support interface inheritance or generics for function pointers, the hooks are stored as `int64`. You must cast your function to an `int64` when creating the `Plugin` struct, and Neditor's core will cast it back to the required signature when invoking the hook.

## The `EditorContext`
Every hook receives and returns an `EditorContext`. This context holds the current state of the editor.

```nitpick
pub struct:EditorContext = {
    TextBuffer:buf;      // The current text buffer (contains the cursor)
    Viewport:vp;         // The visible window metrics
    int32:consume_key;   // (on_key_press only) Set to 1 if you handled the key and want to stop further processing.
    int32:exit_editor;   // Set to 1 to tell Neditor to quit immediately.
};
```

**CRITICAL RULE:** Because Nitpick structs are passed by value, you MUST return the `EditorContext` from your hook functions! If you modify `ctx.buf` (e.g., calling `buffer_insert_char_at_cursor`), you must assign the result back to `ctx.buf` and then `pass ctx;`.

## Example Plugin

Here's an example of a simple plugin that intercepts `Ctrl+P` (ASCII 16) and inserts "Hello from Plugin!" at the cursor.

```nitpick
use "core/plugin.npk".*;
use "core/buffer.npk".*;

// Define our key press hook
func:my_on_key_press = EditorContext(EditorContext:ctx, int32:vk) {
    if (vk == 16i32) { // Ctrl+P
        // Insert text
        string:text = "Hello from Plugin!";
        int32:i = 0i32;
        while (i < @cast<int32>(string_length(text))) {
            string:ch = string_substring(text, @cast<int64>(i), @cast<int64>(i) + 1i64);
            ctx.buf = buffer_insert_char_at_cursor(ctx.buf, ch);
            i = i + 1i32;
        }
        
        // Tell Neditor we consumed this key
        ctx.consume_key = 1i32;
    }
    
    pass ctx;
};

// Define our load hook
func:my_on_load = EditorContext(EditorContext:ctx) {
    // We could do setup here
    pass ctx;
};

pub func:create_my_plugin = Plugin() {
    Plugin:p;
    p.name = "MyAwesomePlugin";
    p.version = "1.0.0";
    
    // Cast function pointers to int64
    p.on_load = @cast<int64>(my_on_load);
    p.on_key_press = @cast<int64>(my_on_key_press);
    
    pass p;
};
```
