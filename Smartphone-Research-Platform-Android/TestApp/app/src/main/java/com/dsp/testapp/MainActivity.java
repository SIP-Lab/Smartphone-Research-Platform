package com.dsp.testapp;

import android.provider.Settings;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity {
    static {
        System.loadLibrary("Algorithm");
    }

    public native String getString();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        TextView log = (TextView)findViewById(R.id.Log);
        log.setText(getString());
    }
}
