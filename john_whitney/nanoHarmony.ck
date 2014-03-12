NanoKONTROL2 nano;
// midi in
MidiIn min;
min.open("nanoSynth SLIDER/KNOB");
MidiMsg msg;
// osc out
OscOut oout;
oout.dest("localhost",12000);
// normalize 0-127 to 0.0-1.0
1.0/127.0 => float midiNorm;

while(min => now){
    while(min.recv(msg)){
        if(nano.knobNum(msg.data2)==0){
            oout.start("/min").add(msg.data3*midiNorm).send();
            <<<"min:",msg.data3*midiNorm>>>;
        }
        else if(nano.knobNum(msg.data2)==1){
            oout.start("/max").add(msg.data3*midiNorm).send();
            <<<"max:",msg.data3*midiNorm>>>;
        }
        else if(nano.knobNum(msg.data2)==2){
            oout.start("/size").add(msg.data3*midiNorm).send();
            <<<"size:",msg.data3*midiNorm>>>;
        }
        else if(nano.knobNum(msg.data2)==3){
            oout.start("/speed").add(msg.data3*midiNorm).send();
            <<<"speed:",msg.data3*midiNorm>>>;
        }
        else if(nano.knobNum(msg.data2)==4){
            oout.start("/cweight").add(msg.data3*midiNorm).send();
            <<<"cweight:",msg.data3*midiNorm>>>;
        }
    }
}