import cv2

class VideoCamera(object):
    def __init__(self):
        # Using OpenCV to capture from device 0.
        self.video = cv2.VideoCapture(0)
	    # self.video = cv2.VideoCapture('image.jpg')
        #self.video = cv2.imread('image.jpg')

    def __del__(self):
        self.video.release()
    
    def get_frame(self):
        #Read: function that gets a frame from cv2 object
        success, image = self.video.read()
        image = cv2.flip(image, 0) #Comment this line if you dont want to flip image
        # We are using Motion JPEG, but OpenCV defaults to capture raw images,
        # so we must encode it into JPEG in order to correctly display the
        # video stream.
        #breakpoint()
        ret, jpeg = cv2.imencode('.jpg', image)
        return jpeg.tobytes()

