//
//  Recipe.h
//  RecipeBook
//
//  Created by Simon on 12/8/12.
//
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, strong) NSString *firstName; // name of recipe
@property (nonatomic,strong) NSString *priority;
@property (nonatomic, strong) NSString *lastName; // preparation time
@property (nonatomic, strong) NSString *imageFile; // image filename of recipe
@property (nonatomic, strong) NSArray *medications; // ingredients
@property (nonatomic, strong) NSString *patID;
@property (nonatomic,strong) NSString *gender;
@end
