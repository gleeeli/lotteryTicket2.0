//
//  DataBaseManager.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/25.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "DataBaseManager.h"

@interface DataBaseManager ()
@property (nonatomic, readwrite, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readwrite, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readwrite, strong) NSManagedObjectContext *context;
@end

static DataBaseManager *dbManager = nil;
@implementation DataBaseManager

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[DataBaseManager alloc] init];
    });
    return dbManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initDatabase];
    }
    return self;
}

- (void)initDatabase
{
    self.userInfoHandle = [[UserInfoHandle alloc] initWithContext:self.context];
}

// 使用懒加载的方式初始化
- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel)
    {
        // url 为CoreDataDemo.xcdatamodeld，注意扩展名为 momd，而不是 xcdatamodeld 类型
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MainModel" withExtension:@"momd"];
        
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

// 同样使用懒加载创建
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator)
    {
        // 创建 coordinator 需要传入 managedObjectModel
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        // 指定本地的 sqlite 数据库文件
        NSURL *sqliteURL = [[self documentDirectoryURL] URLByAppendingPathComponent:@"CoreDataMain.sqlite"];
        NSLog(@"数据库路径：%@",sqliteURL);
        NSError *error;
        // 为 persistentStoreCoordinator 指定本地存储的类型，这里指定的是 SQLite
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:sqliteURL
                                                        options:nil
                                                          error:&error];
        if (error)
        {
            NSLog(@"falied to create persistentStoreCoordinator %@", error.localizedDescription);
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)context
{
    if (!_context)
    {
        // 指定 context 的并发类型： NSMainQueueConcurrencyType 或 NSPrivateQueueConcurrencyType
        _context = [[NSManagedObjectContext alloc ] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _context;
}

// 用来获取 document 目录
- (nullable NSURL *)documentDirectoryURL
{
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}

@end
