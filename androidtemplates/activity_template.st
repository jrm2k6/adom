import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

public class $name$ extends Activity {
    public static Intent getIntent(Context context) {
        return new Intent(context, $name$.class);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about);
    }

    @Override
    protected void onStart() {
        super.onStart();
    }

    @Override
    protected void onStop() {
        super.onStop();
    }
}