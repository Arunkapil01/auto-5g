// MainActivity.java
// This file defines the main activity of the Android application.
// It attempts to open the hidden Android Testing menu (*#*#4636#*#*).

package com.example.testingmenuopener; // Replace 'com.example.testingmenuopener' with your desired package name

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // This activity doesn't need a complex layout, it just triggers an action.
        // You could set a simple layout if you want to show a button or message.
        // setContentView(R.layout.activity_main); // Uncomment if you create activity_main.xml

        openTestingMenu(); // Call the method to open the menu immediately
        finish(); // Close the activity after attempting to open the menu
    }

    /**
     * Attempts to open the Android Testing menu using the *#*#4636#*#* dialer code.
     * It uses an ACTION_DIAL intent, which will open the dialer with the code pre-filled.
     * The user might still need to press the call button, or it might automatically
     * trigger the hidden menu depending on the device.
     */
    private void openTestingMenu() {
        try {
            // The special dialer code *#*#4636#*#* needs to be URI encoded.
            // * is %2A, # is %23
            String encodedHash = Uri.encode("#");
            String dialerCode = "*"+encodedHash+"*"+encodedHash+"4636"+encodedHash+"*"+encodedHash+"*";
            Uri uri = Uri.parse("tel:" + dialerCode);

            Intent intent = new Intent(Intent.ACTION_DIAL, uri);
            // Add a flag to start a new task if the dialer is not already in the current task stack.
            // This helps ensure the intent is handled correctly.
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

            // Check if there's an app that can handle this intent
            if (intent.resolveActivity(getPackageManager()) != null) {
                startActivity(intent);
            } else {
                // Inform the user if no app can handle the intent (e.g., no dialer app)
                Toast.makeText(this, "Could not find an app to handle the dialer code.", Toast.LENGTH_LONG).show();
            }
        } catch (Exception e) {
            // Catch any unexpected errors during intent creation or execution
            Toast.makeText(this, "Error opening testing menu: " + e.getMessage(), Toast.LENGTH_LONG).show();
            e.printStackTrace();
        }
    }
}
