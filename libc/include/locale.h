#ifndef __LOCALE_H_
#define __LOCALE_H_

#ifdef __cplusplus
extern "C" {
#endif

// TODO: documnentation

#define LC_CTYPE 0
#define LC_NUMERIC 1
#define LC_TIME 2
#define LC_COLLATE 3
#define LC_MONETARY 4
#define LC_MESSAGES 5
#define LC_ALL 6

struct lconv
{
	char* decimal_point;
	char* thousands_sep;
	char* grouping;

	char* int_curr_symbol;
	char* currency_symbol;
	char* mon_decimal_point;
	char* mon_thousands_sep;
	char* mon_grouping;
	char* positive_sign;
	char* negative_sign;
	char int_frac_digits;
	char frac_digits;
	char p_cs_precedes;
	char p_sep_by_space;
	char n_cs_precedes;
	char n_sep_by_space;
	char p_sign_posn;
	char n_sign_posn;
	char int_p_cs_precedes;
	char int_p_sep_by_space;
	char int_n_cs_precedes;
	char int_n_sep_by_space;
	char int_p_sign_posn;
	char int_n_sign_posn;
};

#ifndef DISABLE_UNIMPLEMENTED_LIBC_APIS
char* setlocale(int, const char*);
struct lconv* localeconv(void);
#endif

#ifdef __cplusplus
}
#endif

#endif // __LOCALE_H_
