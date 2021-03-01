using System;


#pragma warning disable 1591

namespace TDbInterface
{
    public static class Tlog
    {
        static string line = "";
        public static string Info(string msg)
        {
            if( String.IsNullOrEmpty(msg) || line == msg )
            {
                return msg;
            }
#if SLNX3
            log.Info(msg);
#endif
            line = msg;
            return msg;
        }
        public static string InfoFormat(string Format, params dynamic[] values)
        {
            if (String.IsNullOrEmpty(Format))
            {
                return "";
            }
            line = String.Format(Format, values);
#if SLNX3
            log.InfoFormat(Format, values);
#endif
            return line;
        }
        public static string ErrorFormat(string Format, params dynamic[] values)
        {
            if (String.IsNullOrEmpty(Format) )
            {
                return "";
            }
            line = String.Format(Format, values);
#if SLNX3
            log.ErrorFormat(Format, values);
#endif
            return line;
        }
        public static string WarnFormat(string Format, params dynamic[] values)
        {
            if (String.IsNullOrEmpty(Format) )
            {
                return "";
            }
            line = String.Format(Format, values);
#if SLNX3
            log.WarnFormat(Format, values);
#endif
            return line;
        }
        public static string DebugFormat(string Format, params dynamic[] values)
        {
            if (String.IsNullOrEmpty(Format) )
            {
                return "";
            }
            line = String.Format(Format, values);
#if SLNX3
            log.DebugFormat(Format, values);
#endif
            return line;
        }
        public static string Debug(string msg)
        {
            if (String.IsNullOrEmpty(msg) || line == msg)
            {
                return msg;
            }
#if SLNX3
            log.Debug(msg);
#endif
            return line;
        }
        public static string Error(string msg)
        {
            if (String.IsNullOrEmpty(msg) || line == msg)
            {
                return msg;
            }
            line = msg;
#if SLNX3
            log.Error(msg);
#endif
            return line;
        }
        public static string Warn(string msg)
        {
            if (String.IsNullOrEmpty(msg) || line == msg)
            {
                return msg;
            }
            line = msg;
#if SLNX3
            log.Warn(msg);
#endif
            return line;
        }
        public static void SetLogPath(string path, string errorPath)
        {
        }
    }
}