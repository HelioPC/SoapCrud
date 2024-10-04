-- CreateTable
CREATE TABLE `Employee` (
    `employeeId` BIGINT NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `department` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NOT NULL,
    `address` VARCHAR(255) NULL,

    UNIQUE INDEX `User_name_key`(`name`),
    UNIQUE INDEX `User_phone_key`(`phone`),
    PRIMARY KEY (`employeeId`)
)
