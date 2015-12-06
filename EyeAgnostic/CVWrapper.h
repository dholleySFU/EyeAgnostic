//
//  CVWrapper.h
//  CVOpenTemplate
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CVWrapper : NSObject

+ (UIImage*) analyzeWithOpenCV: (UIImage*) inputImage;

+ (bool) analyzeResultWithOpenCV: (UIImage*) inputImage;

@end
