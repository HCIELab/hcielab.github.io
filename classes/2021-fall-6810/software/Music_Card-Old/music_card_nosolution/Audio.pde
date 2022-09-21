import processing.sound.*;
import java.io.FilenameFilter;
ArrayList<SoundFile> songs = new ArrayList<SoundFile>();
Sound volume;


class Audio{
  
  int song_number = 0;
  boolean playing = false;
  
  Audio(PApplet p){
    
    volume = new Sound(p);//controls the volume of touch sensing setup
    
    //add your songs here
    songs.add(new SoundFile(p, "2019-05-04_-_I_Was_Joking_-_David_Fesliyan.mp3"));
    songs.add(new SoundFile(p, "2019-06-20_-_Riding_Solo_-_David_Fesliyan.mp3"));
    songs.add(new SoundFile(p, "2019-06-05_-_Big_Band_-_www.fesliyanstudios.com_-_David_Renda.mp3"));
  
  }
  
//when I try going forward it does not stop playing the last song
  public void play(){  
    
      playing = true;
      
      song_number = song_number<0?songs.size()-1:song_number;
      song_number = song_number>=songs.size()?0:song_number;
      println("Song Number: ",song_number);

      songs.get(song_number).play();
        
  }
  
  public boolean isPlaying(){
    return playing;
  }
  
  public void songFinished(){   
    if(isPlaying() && !songs.get(song_number).isPlaying()) forward();    
  }
  
  public void pause(){
    playing = false;
    songs.get(song_number).pause();
  }
  
  public void forward(){
    songs.get(song_number).stop();
    songs.get(song_number).cue(0);
    song_number++;
    play();
  }
  
  public void back(){
    songs.get(song_number).cue(0);
    song_number--;
    play();
  }
  
  public void changeVolume(double intensity){
    volume.volume((float)(intensity));
  }
  
  
}
