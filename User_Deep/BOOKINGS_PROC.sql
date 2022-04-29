create or replace PACKAGE PKG_BOOKING   AS 
    
    FUNCTION NEW_BOOKING_VALIDATION(
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vUSER_ID IN BOOKING.USER_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
    ) RETURN VARCHAR2;

    FUNCTION BOOKING_IN_PROGRESS_VALIDATION(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type,
            vLISTING_ID IN BOOKING.LISTING_ID%type
    ) RETURN VARCHAR2;

    FUNCTION BOOKING_COMPLETED_VALIDATION(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
    ) RETURN VARCHAR2;

    FUNCTION BOOKING_PAYMENT_VALIDATION(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    ) RETURN VARCHAR2;

    PROCEDURE INSERT_NEW_BOOKING(
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vUSER_ID IN BOOKING.USER_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
    );

    PROCEDURE BOOKING_IN_PROGRESS(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
    );

    PROCEDURE BOOKING_COMPLETED(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type,
        vCOMMENTS IN BOOKING.COMMENTS%type
    );

    PROCEDURE BOOKING_PAYMENT_SUCCESS(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    );

    PROCEDURE BOOKING_PAYMENT_FAIL(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    );

    PROCEDURE BOOKING_CANCELLED(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    );

	 FUNCTION COMPARE_TIMESTAMP(
        VTIME_ONE IN TIMESTAMP,
        VTIMESTAMP_TWO IN TIMESTAMP
    ) RETURN VARCHAR2;

END PKG_BOOKING;
/



create or replace PACKAGE BODY PKG_BOOKING   AS

    -- Validations while adding a new booking
    FUNCTION NEW_BOOKING_VALIDATION(
            vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
            vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
            vUSER_ID IN BOOKING.USER_ID%type,
            vLISTING_ID IN BOOKING.LISTING_ID%type
        ) RETURN VARCHAR2 AS

                EXISTING_BOOKING NUMBER;
                INVALID_BOOKING_EX EXCEPTION;
                INVALID_BOOKING_VAL_EX EXCEPTION;
                CREATED_START_DATE_EX EXCEPTION;
                CREATED_END_DATE_EX EXCEPTION;
                DUPLICATE_BOOKING_EX EXCEPTION;
                CREATED_START_DATE_LESS_THAN_SYS_EX EXCEPTION;
                CREATED_START_DATE_SMALLER_EX EXCEPTION;
                CREATED_END_DATE_LESS_THAN_SYS_EX EXCEPTION;
                ACTUAL_START_DATE_LESS_THAN_SYS_EX EXCEPTION;
                ACTUAL_START_DATE_SMALLER_EX EXCEPTION;
                ACTUAL_END_DATE_LESS_THAN_SYS_EX EXCEPTION;
                INVALID_CREATED_START_DATE_FORMAT EXCEPTION;
                INVALID_CREATED_END_DATE_FORMAT EXCEPTION;
                INVALID_USER_ID_EX EXCEPTION;
                INVALID_LISTING_ID_EX EXCEPTION;
                EXISTS_USER_ID_EX EXCEPTION;
                EXISTS_LISTING_ID_EX EXCEPTION;
                USER_EXISTS NUMBER;
                LISTING_EXISTS NUMBER;

        BEGIN

            SELECT COUNT(*) INTO USER_EXISTS FROM USERS WHERE USER_ID=UPPER(TRIM(vUSER_ID));
            SELECT COUNT(*) INTO LISTING_EXISTS FROM CAR_LISTING WHERE LISTING_ID=UPPER(TRIM(vLISTING_ID));

            -- CHECK IF USER ID IS BLANK OR NULL
            if vUSER_ID is NULL or LENGTH(trim(vUSER_ID)) IS NULL then
                raise INVALID_USER_ID_EX;
            end if;

            if USER_EXISTS = 0 then
                raise EXISTS_USER_ID_EX;
            end if;

            -- CHECK IF LISTING ID IS BLANK OR NULL
            if LISTING_EXISTS = 0 then
                raise EXISTS_LISTING_ID_EX;
            end if;

            -- CHECK IF CREATED_START_DATE IS BLANK OR NULL
            if vCREATED_START_DATE is NULL or to_char(LENGTH(vCREATED_START_DATE)) is NULL then
                raise CREATED_START_DATE_EX;
            end if;

            -- CHECK IF CREATED_END_DATE IS BLANK OR NULL
            if vCREATED_END_DATE is NULL or to_char(LENGTH(vCREATED_END_DATE)) is NULL then
                raise CREATED_END_DATE_EX;
            end if;

            -- CHECK IF CREATED_START_DATE IS GREATER THAN CURRENT_DATE
            -- if COMPARE_TIMESTAMP(vCREATED_START_DATE, SYSTIMESTAMP ) < 0 then
            --     raise CREATED_START_DATE_LESS_THAN_SYS_EX;
            -- end if;

            -- CHECK IF CREATED_START_DATE IS LESS THAN CREATED_END_DATE
            -- if COMPARE_TIMESTAMP(vCREATED_END_DATE, vCREATED_START_DATE ) < 0 then
            --     raise CREATED_START_DATE_SMALLER_EX;
            -- end if;

            -- CHECK IF CREATED_END_DATE IS GREATER THAN CURRENT_DATE
            -- if COMPARE_TIMESTAMP(vCREATED_END_DATE, SYSTIMESTAMP ) < 0 then
            --     raise CREATED_END_DATE_LESS_THAN_SYS_EX;
            -- end if;

            RETURN 'YES';
        EXCEPTION
            when INVALID_BOOKING_EX then
                dbms_output.put_line('[ERROR] Invalid Booking Type, Booking Type cannot be NULL or Empty');
                RETURN 'NO';
            when INVALID_BOOKING_VAL_EX then
                dbms_output.enable(10000);
                dbms_output.put_line('[ERROR] Invalid Booking Type, allowed values are ''COMPLETED'', ''IN-PROGRESS'',''OPEN''');
                RETURN 'NO';
            when CREATED_START_DATE_EX then
                dbms_output.put_line('[ERROR] Invalid Created Start Date, Enter a valid Created Start Date');
                RETURN 'NO';
            when CREATED_END_DATE_EX then
                dbms_output.put_line('[ERROR] Invalid Created End Date, Enter a valid Created End Date');
                RETURN 'NO';
            when DUPLICATE_BOOKING_EX then
                dbms_output.put_line('[ERROR] Duplicate booking, booking with the same id already exists');
                RETURN 'NO';
            when CREATED_START_DATE_LESS_THAN_SYS_EX then
                dbms_output.put_line('[ERROR] CreatedStartDate cannot be less the current date');
                RETURN 'NO';
            when CREATED_START_DATE_SMALLER_EX then
                dbms_output.put_line('[ERROR] CreatedStartDate cannot be less the CreatedEndDate');
                RETURN 'NO';
            when CREATED_END_DATE_LESS_THAN_SYS_EX then
                dbms_output.put_line('[ERROR] CreatedEndDate cannot be less the current date');
                RETURN 'NO';
            when INVALID_CREATED_START_DATE_FORMAT then
                dbms_output.put_line('[ERROR] CreatedStartDate has an Invalid format');
                RETURN 'NO';
            when INVALID_CREATED_END_DATE_FORMAT then
                dbms_output.put_line('[ERROR] CreatedEndDate has an Invalid format');
                RETURN 'NO';
            when INVALID_USER_ID_EX then
                dbms_output.put_line('[ERROR] Invalid UserId');
                RETURN 'NO';
            when INVALID_LISTING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid ListingId');
                RETURN 'NO';
            when EXISTS_USER_ID_EX then
                dbms_output.put_line('[ERROR] User does not exist');
                RETURN 'NO';
            when EXISTS_LISTING_ID_EX then
                dbms_output.put_line('[ERROR] Listing does not exist');
                RETURN 'NO';
            when others then
                RETURN 'NO';
    END NEW_BOOKING_VALIDATION;

    -- Validations while updating a booking to IN-PROGRESS
    FUNCTION BOOKING_IN_PROGRESS_VALIDATION(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type,
            vLISTING_ID IN BOOKING.LISTING_ID%type
        ) RETURN VARCHAR2 AS

                BOOKING_STATUS_INPROG NUMBER;
                BOOKING_STATUS_COMP NUMBER;
                vIS_BOOKING_PRESENT NUMBER;
                NO_BOOKING_EX EXCEPTION;
                INVALID_BOOKING_ID_EX EXCEPTION;
                INVALID_LISTING_ID_EX EXCEPTION;
                BOOKING_INPROG_EX EXCEPTION;
                BOOKING_COMP_EX EXCEPTION;

        BEGIN
            SELECT COUNT(*) INTO BOOKING_STATUS_INPROG FROM BOOKING WHERE BOOKING_STATUS='IN-PROGRESS' AND BOOKING_ID=vBOOKING_ID;
            SELECT COUNT(*) INTO BOOKING_STATUS_COMP FROM BOOKING WHERE BOOKING_STATUS='COMPLETED' AND BOOKING_ID=vBOOKING_ID;
            SELECT COUNT(*) INTO vIS_BOOKING_PRESENT FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;

            -- CHECK IF BOOKING ID IS BLANK OR NULL
            if vBOOKING_ID is NULL or LENGTH(trim(vBOOKING_ID)) IS NULL then
                raise INVALID_BOOKING_ID_EX;
            end if;

            -- CHECK IF LISTING ID IS BLANK OR NULL
            if vLISTING_ID is NULL or LENGTH(trim(vLISTING_ID)) IS NULL then
                raise INVALID_LISTING_ID_EX;
            end if;

            -- CHECK IF BOOKING ID IS PRESENT
            if vIS_BOOKING_PRESENT=0 then
                raise NO_BOOKING_EX;
            end if;

            -- CHECK IF BOOKING IS ALREADY IN PROGRESS
            if BOOKING_STATUS_INPROG > 0 then
                raise BOOKING_INPROG_EX;
            end if;

            -- CHECK IF BOOKING IS ALREADY COMPLETED
            if BOOKING_STATUS_COMP > 0 then
                raise BOOKING_COMP_EX;
            end if;

            RETURN 'YES';
        EXCEPTION
            when INVALID_BOOKING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Booking ID, Booking ID cannot be NULL or Empty');
                RETURN 'NO';
            when NO_BOOKING_EX then
                dbms_output.put_line('[ERROR] Provided Booking is not present in the database');
                RETURN 'NO';
            when INVALID_LISTING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Listing ID, Listin ID cannot be NULL or Empty');
                RETURN 'NO';
            when BOOKING_INPROG_EX then
                dbms_output.put_line('[ERROR] This booking is already IN_PROGRESS');
                RETURN 'NO';
            when BOOKING_COMP_EX then
                dbms_output.put_line('[ERROR] This booking has been completed');
                RETURN 'NO';
            when others then
                RETURN 'NO';
    END BOOKING_IN_PROGRESS_VALIDATION;

    -- Validations while updating a booking to COMPLETED
    FUNCTION BOOKING_COMPLETED_VALIDATION(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type,
            vLISTING_ID IN BOOKING.LISTING_ID%type
        ) RETURN VARCHAR2 AS

                BOOKING_STATUS_INITIAL NUMBER;
                BOOKING_STATUS_COMP NUMBER;
                INVALID_BOOKING_ID_EX EXCEPTION;
                BOOKING_INITIAL_EX EXCEPTION;
                BOOKING_COMP_EX EXCEPTION;
                INVALID_LISTING_ID_EX EXCEPTION;

        BEGIN
            SELECT COUNT(*) INTO BOOKING_STATUS_INITIAL FROM BOOKING WHERE BOOKING_STATUS='INITIAL' AND BOOKING_ID=vBOOKING_ID;
            SELECT COUNT(*) INTO BOOKING_STATUS_COMP FROM BOOKING WHERE BOOKING_STATUS='COMPLETED' AND BOOKING_ID=vBOOKING_ID;

            -- CHECK IF BOOKING ID IS BLANK OR NULL
            if vBOOKING_ID is NULL or LENGTH(trim(vBOOKING_ID)) IS NULL then
                raise INVALID_BOOKING_ID_EX;
            end if;

            -- CHECK IF LISTING ID IS BLANK OR NULL
            if vLISTING_ID is NULL or LENGTH(trim(vLISTING_ID)) IS NULL then
                raise INVALID_LISTING_ID_EX;
            end if;

            -- CHECK IF BOOKING IS ALREADY IN PROGRESS
            if BOOKING_STATUS_INITIAL > 0 then
                raise BOOKING_INITIAL_EX;
            end if;

            -- CHECK IF BOOKING IS ALREADY COMPLETED
            if BOOKING_STATUS_COMP > 0 then
                raise BOOKING_COMP_EX;
            end if;

            RETURN 'YES';
        EXCEPTION
            when INVALID_BOOKING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Booking ID, Booking ID cannot be NULL or Empty');
                RETURN 'NO';
            when BOOKING_INITIAL_EX then
                dbms_output.put_line('[ERROR] This booking is still in INITIAL state');
                RETURN 'NO';
            when BOOKING_COMP_EX then
                dbms_output.put_line('[ERROR] This booking has already been completed');
                RETURN 'NO';
            when INVALID_LISTING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Listing ID, Listing ID cannot be NULL or Empty');
                RETURN 'NO';
            when others then
                RETURN 'NO';
    END BOOKING_COMPLETED_VALIDATION;

    -- Validations while updating a booking to PAYMENT-SUCCESS
    FUNCTION BOOKING_PAYMENT_VALIDATION(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type
        ) RETURN VARCHAR2 AS

            INVALID_BOOKING_ID_EX EXCEPTION;

        BEGIN

            -- CHECK IF BOOKING ID IS BLANK OR NULL
            if vBOOKING_ID is NULL or LENGTH(trim(vBOOKING_ID)) IS NULL then
                raise INVALID_BOOKING_ID_EX;
            end if;

            RETURN 'YES';
        EXCEPTION
            when INVALID_BOOKING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Booking ID, Booking ID cannot be NULL or Empty');
                RETURN 'NO';
            when others then
                RETURN 'NO';
    END BOOKING_PAYMENT_VALIDATION;

    -- Function to compare the timestamps
    FUNCTION COMPARE_TIMESTAMP(
        VTIME_ONE IN TIMESTAMP,
        VTIMESTAMP_TWO IN TIMESTAMP
        ) RETURN VARCHAR2 AS

        begin
        return extract (day    from (VTIME_ONE-VTIMESTAMP_TWO))*24*60*60 +
                extract (hour   from (VTIME_ONE-VTIMESTAMP_TWO))*60*60+
                extract (minute from (VTIME_ONE-VTIMESTAMP_TWO))*60+
                extract (second from (VTIME_ONE-VTIMESTAMP_TWO));
	end COMPARE_TIMESTAMP;

    -- Procedure to add a new booking
    PROCEDURE INSERT_NEW_BOOKING(
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vUSER_ID IN BOOKING.USER_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
        ) AS
            vCOMPLETED_COUNT NUMBER;
            v1BOOKING_ID BOOKING.BOOKING_ID%TYPE;
            vDAYS NUMBER(5,2);
            EXISTING_BOOKING NUMBER;
            vFEE_RATE NUMBER(5,2);
			vBLACKLISTED USERS.BLACKLISTED%TYPE;
            FETCH_TRANSACTION_ID TRANSACTION.TRANSACTION_ID%TYPE;
            EXSTING_BOOKING_EX EXCEPTION;
            INVALID_INPUT_EX EXCEPTION;
			NO_DATA_EX EXCEPTION;
			USER_BLACKLISTED_EX EXCEPTION;
        BEGIN
            SELECT COUNT(*) INTO EXISTING_BOOKING FROM BOOKING WHERE USER_ID=vUSER_ID AND BOOKING_STATUS IN ('INITIAL', 'IN-PROGRESS', 'COMPLETED', 'PAYMENT_FAILED');

            -- IF THE USER HAS AN EXSTING OPEN BOOKING, DONT ALLOW TO RE-BOOK
            IF EXISTING_BOOKING > 0 THEN
                RAISE EXSTING_BOOKING_EX;
            END IF;

            -- validate address
        IF NEW_BOOKING_VALIDATION(vCREATED_START_DATE, vCREATED_END_DATE, vUSER_ID, vLISTING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

			BEGIN
				SELECT BLACKLISTED INTO vBLACKLISTED FROM USERS WHERE USER_ID=vUSER_ID;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
			END;


			if (vBLACKLISTED is not NULL or LENGTH(trim(vBLACKLISTED))IS not NULL) and upper(trim(vBLACKLISTED)) = 'TRUE' then
                raise USER_BLACKLISTED_EX;
            end if;

            -- CALCULATE THE NUMBER OF DAYS OF THE BOOKING
            vDAYS := CAST(vCREATED_END_DATE AS DATE) - CAST(vCREATED_START_DATE AS DATE);

            -- IF THE DIFFERENCE IS 0 DAYS, IT NEEDS TO BE CONSIDERED AS 1 DAY
            IF vDAYS = 0 THEN
                vDAYS := 1;
            END IF;

            -- GET THE FEE RATE FROM CAR_LISTING ENTITY
            SELECT FEE_RATE INTO vFEE_RATE FROM CAR_LISTING WHERE LISTING_ID=vLISTING_ID;

            -- GET THE VALUE OF LISTING_IF FROM CAR_REGISTRATION ENTITY
            PKG_TRANSACTION.BODY_TRANSACTION('PENDING', vDAYS * vFEE_RATE, FETCH_TRANSACTION_ID);

            INSERT INTO BOOKING(BOOKING_ID, BOOKING_STATUS, CREATED_START_DATE, CREATED_END_DATE, USER_ID,TRANSACTION_ID,LISTING_ID) VALUES(
                'BOOK_'||BOOKING_ID_SEQ.NEXTVAL,'INITIAL',vCREATED_START_DATE,vCREATED_END_DATE,vUSER_ID,FETCH_TRANSACTION_ID,vLISTING_ID
            );

        EXCEPTION
            when EXSTING_BOOKING_EX then
                dbms_output.put_line('[ERROR] There is an open booking or a pending payment for this customer which needs to be taken care of before booking another ride');
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
            when USER_BLACKLISTED_EX then
                dbms_output.put_line('[ERROR] User blacklisted. Cannot book a ride');
    END INSERT_NEW_BOOKING;

    -- Procedure to update a booking to IN-PROGRESS
    PROCEDURE BOOKING_IN_PROGRESS(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
        ) AS
            INVALID_INPUT_EX EXCEPTION;
        BEGIN
        -- validate BOOKING
        IF BOOKING_IN_PROGRESS_VALIDATION(vBOOKING_ID,vLISTING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        -- UPDATE THE BOOKING STATUS
        UPDATE BOOKING SET BOOKING_STATUS='IN-PROGRESS', ACTUAL_START_DATE=LOCALTIMESTAMP WHERE BOOKING_ID=vBOOKING_ID;

        EXCEPTION
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
    END BOOKING_IN_PROGRESS;

    -- Procedure to update a booking to COMPLETED
    PROCEDURE BOOKING_COMPLETED(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type,
        vCOMMENTS IN BOOKING.COMMENTS%type
        ) AS
            vDAYS NUMBER(5,2);
            vFEE_RATE NUMBER(5,2);
            vACTUAL_START_DATE TIMESTAMP;
            vTRANSACTION_ID BOOKING.TRANSACTION_ID%TYPE;
            INVALID_INPUT_EX EXCEPTION;
        BEGIN
            -- validate BOOKING
        IF BOOKING_COMPLETED_VALIDATION(vBOOKING_ID, vLISTING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        SELECT ACTUAL_START_DATE INTO vACTUAL_START_DATE FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;

        vDAYS := CAST(LOCALTIMESTAMP AS DATE) - CAST(vACTUAL_START_DATE AS DATE);

        -- IF THE DIFFERENCE IS 0 DAYS, IT NEEDS TO BE CONSIDERED AS 1 DAY
            IF vDAYS = 0 THEN
                vDAYS := 1;
            END IF;

        SELECT FEE_RATE INTO vFEE_RATE FROM CAR_LISTING WHERE LISTING_ID=vLISTING_ID;

        SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;

        PKG_TRANSACTION.BODY_TRANSACTION_UPDATE_TABLE(vTRANSACTION_ID,'PENDING', vDAYS * vFEE_RATE);

        -- UPDATE THE BOOKING STATUS
        UPDATE BOOKING SET BOOKING_STATUS='COMPLETED', COMMENTS=vCOMMENTS, ACTUAL_END_DATE=LOCALTIMESTAMP WHERE BOOKING_ID=vBOOKING_ID;

        EXCEPTION
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
    END BOOKING_COMPLETED;

    -- Procedure to update a booking to PAYMENT-SUCCESS
    PROCEDURE BOOKING_PAYMENT_SUCCESS(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
        ) AS
            vACTUAL_START_DATE TIMESTAMP;
            RECORD_COUNT NUMBER;
            vTRANSACTION_ID BOOKING.TRANSACTION_ID%TYPE;
            PAID NUMBER;
            INITIAL1 NUMBER;
            IN_PROGRESS NUMBER;
            INVALID_INPUT_EX EXCEPTION;
            NO_RECORD_EX EXCEPTION;
            PAID_EX EXCEPTION;
            INITIAL_EX EXCEPTION;
            IN_PROG_EX EXCEPTION;
        BEGIN
            -- validate BOOKING
        IF BOOKING_PAYMENT_VALIDATION(vBOOKING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        SELECT COUNT(*) TRANSACTION_ID INTO RECORD_COUNT FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
        SELECT COUNT(*) BOOKING_STATUS INTO PAID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='PAYMENT_DONE';
        SELECT COUNT(*) BOOKING_STATUS INTO INITIAL1 FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='INITIAL';
        SELECT COUNT(*) BOOKING_STATUS INTO IN_PROGRESS FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='IN-PROGRESS';

        IF RECORD_COUNT = 0 THEN
            RAISE NO_RECORD_EX;
        END IF;

        IF PAID != 0 THEN
            RAISE PAID_EX;
        END IF;

        IF INITIAL1 != 0 THEN
            RAISE INITIAL_EX;
        END IF;

        IF IN_PROGRESS != 0 THEN
            RAISE IN_PROG_EX;
        END IF;

        SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
        PKG_TRANSACTION.BODY_TRANSACTION_UPDATE_TABLE_SUCCESS(vTRANSACTION_ID, 'SUCCESS');

        -- UPDATE THE BOOKING STATUS
        UPDATE BOOKING SET BOOKING_STATUS='PAYMENT_DONE', ACTUAL_END_DATE=LOCALTIMESTAMP WHERE BOOKING_ID=vBOOKING_ID;

        EXCEPTION
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
            when NO_RECORD_EX then
                dbms_output.put_line('[ERROR] No records found for the provided Booking ID');
            when PAID_EX then
                dbms_output.put_line('[ERROR] Booking already completed and paid');
            when INITIAL_EX then
                dbms_output.put_line('[ERROR] Booking still in INITIAL state, needs to be completed for payment');
            when IN_PROG_EX then
                dbms_output.put_line('[ERROR] Booking still in IN-PROGRESS state, needs to be completed for payment');
    END BOOKING_PAYMENT_SUCCESS;

    -- Procedure to update a booking to PAYMENT-FAILED
    PROCEDURE BOOKING_PAYMENT_FAIL(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
        ) AS
            vACTUAL_START_DATE TIMESTAMP;
            RECORD_COUNT NUMBER;
            vTRANSACTION_ID BOOKING.TRANSACTION_ID%TYPE;
            PAID NUMBER;
            INITIAL1 NUMBER;
            IN_PROGRESS NUMBER;
            INVALID_INPUT_EX EXCEPTION;
            NO_RECORD_EX EXCEPTION;
            PAID_EX EXCEPTION;
            INITIAL_EX EXCEPTION;
            IN_PROG_EX EXCEPTION;
        BEGIN
            -- validate BOOKING
        IF BOOKING_PAYMENT_VALIDATION(vBOOKING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        SELECT COUNT(*) TRANSACTION_ID INTO RECORD_COUNT FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
        SELECT COUNT(*) BOOKING_STATUS INTO PAID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='PAYMENT_FAILED';
        SELECT COUNT(*) BOOKING_STATUS INTO INITIAL1 FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='INITIAL';
        SELECT COUNT(*) BOOKING_STATUS INTO IN_PROGRESS FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='IN-PROGRESS';

        IF RECORD_COUNT = 0 THEN
            RAISE NO_RECORD_EX;
        END IF;

        IF PAID != 0 THEN
            RAISE PAID_EX;
        END IF;

        IF INITIAL1 != 0 THEN
            RAISE INITIAL_EX;
        END IF;

        IF IN_PROGRESS != 0 THEN
            RAISE IN_PROG_EX;
        END IF;

        SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
        PKG_TRANSACTION.BODY_TRANSACTION_UPDATE_TABLE_SUCCESS(vTRANSACTION_ID, 'FAILED');

        -- UPDATE THE BOOKING STATUS
        UPDATE BOOKING SET BOOKING_STATUS='PAYMENT_FAILED', ACTUAL_END_DATE=LOCALTIMESTAMP WHERE BOOKING_ID=vBOOKING_ID;

        EXCEPTION
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
            when NO_RECORD_EX then
                dbms_output.put_line('[ERROR] No records found for the provided Booking ID');
            when PAID_EX then
                dbms_output.put_line('[ERROR] Booking already in failed state');
            when INITIAL_EX then
                dbms_output.put_line('[ERROR] Booking still in INITIAL state, needs to be completed for payment');
            when IN_PROG_EX then
                dbms_output.put_line('[ERROR] Booking still in IN-PROGRESS state, needs to be completed for payment');
    END BOOKING_PAYMENT_FAIL;

    -- Procedure to cancel a booking
    PROCEDURE BOOKING_CANCELLED(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type
        ) AS
            vCREATED_DATE_TIME BOOKING.CREATED_START_DATE%TYPE;
            CANCELLED_COUNT NUMBER;
            vTRANSACTION_ID BOOKING.TRANSACTION_ID%TYPE;
            NO_DATA_EX EXCEPTION;
            CANNOT_CANCEL_EX EXCEPTION;
            ALREADY_CANCELLED_EX EXCEPTION;
        BEGIN
            -- Fetch the created start date for the user
            BEGIN
                SELECT CREATED_START_DATE INTO vCREATED_DATE_TIME FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
            END;

            -- fetch the transaction id for the user
            BEGIN
                SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
            END;

            -- fetch the count of cancelled booking for the current user
            BEGIN
                SELECT COUNT(*) INTO CANCELLED_COUNT FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='CANCELLED';
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
            END;

            -- raise an exception if the booking for the current user is already cancelled
            IF CANCELLED_COUNT > 0 THEN
                RAISE ALREADY_CANCELLED_EX;
            END IF;

            -- dont allow cancellation if the time of cancellation is after the created start date
            IF vCREATED_DATE_TIME > LOCALTIMESTAMP THEN
                UPDATE BOOKING SET BOOKING_STATUS='CANCELLED' WHERE BOOKING_ID=vBOOKING_ID;
            ELSE
                RAISE CANNOT_CANCEL_EX;
            END IF;

            -- change the total cost of the user to 0 after cancellation
            UPDATE TRANSACTION SET TOTAL_COST = 0.0, STATUS='CANCELLED' WHERE TRANSACTION_ID=vTRANSACTION_ID;
        EXCEPTION
            when CANNOT_CANCEL_EX then
                dbms_output.put_line('[ERROR] Cannot cancel the booking after the Start Time of the booking');
            when ALREADY_CANCELLED_EX then
                dbms_output.put_line('[ERROR] The booking is already in CANCELLED state');
            when NO_DATA_EX then
                dbms_output.put_line('[ERROR] No records found');
        END;

END PKG_BOOKING;
/